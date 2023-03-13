class RoomsController < ApplicationController
  include RoomsHelper
  include Pagy::Backend
  before_action :authenticate_owner!, except: %i[ index show images ]
  before_action :set_room, only: %i[ show edit update destroy images ]
  before_action :room_ownership, only: %i[ edit update destroy ]
  before_action :set_locations, :locations_count, only: %i[ new edit ]
  before_action :validate_images, only: %i[ create ]
  before_action :set_search_params, :set_rooms, only: %i[ index ]

  def index
    if @rooms.blank?
      @pagy, @pagy_rooms = pagy(Room.default_order)
      flash.now.alert = "No match found. Displaying all rooms." if @place.present? and notify?
    else
      @pagy, @pagy_rooms = pagy(@rooms)
      flash.now.notice = "#{view_context.pluralize(@rooms.size, "room")} found." if notify?
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
    @room.location = Location.find(room_params[:location]) if room_params[:location].present?

    if @room.save
      redirect_to room_path(@room), notice: "Room was successfully listed."
    else
      redirect_to new_room_path, alert: "Room was not listed.", status: 302
    end
  end

  def edit
    @tags = Tag.names_to_hash
  end

  def update
    @room.images.purge
    @room.location = Location.find(room_params[:location]) if room_params[:location].present? 

    if @room.update(room_params.except(:location))
      redirect_to room_path(@room), notice: "Room details was successfully updated."
    else
      redirect_to edit_room_path(@room), alert: "Room was not updated.", status: 302
    end
  end

  def destroy
    @room.images.purge
    @room.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@room) }
      format.html         { redirect_to dashboard_path }
    end
  end

  def images
    if params[:active].present?
      @active = @room.images.find(params[:active])&.id
    else
      @active = @room.images.first&.id
    end
    render partial: "images"
  end

  private
  def room_ownership
    redirect_to root_path unless current_owner&.rooms.include?(@room)
  end

  def locations_count
    redirect_to new_location_path, alert: "You must add a location first." if current_owner&.locations.count.zero?
  end

  def set_room
    @room = Room.includes_attachments.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :rent, :capacity, :vacancies, :description, :location, tags: [], images: [])
  end

  def set_rooms
    if @place.present?
      if @sort_option.has_key?(:distance)
        locations = Location.order_near(@place, @distance, @sort_option)
        room_ids = Room.rentable_ids(locations, @rent)
        @rooms = Room.where_order_maintained(room_ids)
      else
        location_ids = Location.near_ids(@place, @distance)
        @rooms = Room.rentables(location_ids, @rent, @sort_option)
      end
    else
      @rooms = Room.includes_all.order(@sort_option)
    end
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
    @place = search_params[:place]
    @center = Location.geocode_place(@place)
    @distance = search_params[:distance]&.to_i || 20
    @rent = search_params[:rent]&.to_f || 20000
    @sort_option = Room.sort_option(search_params[:sort])
  end
end
