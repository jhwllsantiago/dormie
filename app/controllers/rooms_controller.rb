class RoomsController < ApplicationController
  include RoomsHelper
  before_action :authenticate_owner!, except: %i[ index show ]
  before_action :set_room, only: %i[ show edit update destroy ]
  before_action :room_ownership, only: %i[ edit update destroy ]
  before_action :set_locations, only: %i[ new edit ]
  before_action :validate_images, only: %i[ create ]
  before_action :set_search_params, only: %i[ index ]

  def index
    if search_params[:place].present?
      if @sort_option[0] == :distance
        locations = locations_sorted_by_distance
        collect_rooms_and_filter(locations)
      else
        locations = Location.near(search_params[:place], @distance)
        sort_rooms_and_filter(locations)
      end
    end
    
    if @rooms.blank?
      @rooms = Room.includes(:location).order(updated_at: :desc)
      flash.now.alert = "No match found. Displaying all rooms." if search_params[:place].present?
    else
      flash.now.notice = "#{view_context.pluralize(@rooms.size, "room")} found."
    end
  end

  def show
    @tags = Tag.where(id: @room.tags)
    if occupant_signed_in?
      @review = @room.reviews.find_by(occupant: current_occupant)
      @reviews = @room.reviews.where.not(occupant: current_occupant).order(updated_at: :desc)
    else
      @review = nil
      @reviews = @room.reviews.order(updated_at: :desc)
    end
  end

  def new
    @tags = Tag.names_to_hash
    @room = Room.new
  end

  def create
    @room = Room.new(room_params.except(:location))
    @room.location = Location.find(room_params[:location])

    if @room.save
      redirect_to room_url(@room), notice: "Room was successfully created."
    else
      redirect_to new_room_path, alert: "Room was not created.", status: :unprocessable_entity
    end
  end

  def edit
    @tags = Tag.names_to_hash
  end

  def update
    @room.images.purge
    @room.location = Location.find(room_params[:location]) if room_params[:location].present? 

    if @room.update(room_params.except(:location))
      redirect_to room_url(@room), notice: "Room details was successfully updated."
    else
      redirect_to new_room_path, alert: "Room was not created.", status: :unprocessable_entity
    end
  end

  def destroy
    @room.images.purge
    @room.destroy

    render partial: "pages/dashboard/rooms", locals: { rooms: current_owner.rooms.includes(:location) }
  end

  private
  def room_ownership
    redirect_to root_path unless current_owner&.rooms.include?(@room)
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :rent, :capacity, :vacancies, :description, :location, tags: [], images: [])
  end

  def set_locations
    @locations = current_owner.locations
  end

  def validate_images
    return if room_params[:images].nil?
    room_params[:images].each do |image|
      if image.size > 4.megabytes
        flash.alert = "Please upload images less than 4MB in size."
        redirect_to new_room_path, status: :unprocessable_entity
      elsif !image.content_type.in?(%w[ image/jpeg image/png ])
        flash.alert = "Please upload images in jpeg or png format."
        redirect_to new_room_path, status: :unprocessable_entity
      end
    end
  end

  def search_params
    params.permit(:place, :distance, :rent, :sort, :commit)
  end

  def set_search_params
    @rooms = []
    @center = MapsHelper.geocode_param(params[:place])
    @distance = search_params[:distance]&.to_i || 20
    @rent = search_params[:rent]&.to_f || 20000
    @sort_option = extract_sort_option(search_params[:sort])
  end

  def locations_sorted_by_distance
    Location.near(search_params[:place], @distance)
      .includes(:rooms)
      .reorder(@sort_option[0] => @sort_option[1])
  end

  def collect_rooms_and_filter locations
    locations.each do |location|
      location.rooms.each do |room|
        @rooms << room if @rent >= room.rent
      end
    end
  end

  def sort_rooms_and_filter locations
    return if locations.blank?
    @rooms = Room.includes(:location)
      .where(location: locations.pluck(:id), rent: ..@rent)
      .order(@sort_option[0] => @sort_option[1])
  end
end
