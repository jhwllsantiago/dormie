class RoomsController < ApplicationController
  before_action :authenticate_owner!, except: %i[ index show ]
  before_action :set_room, only: %i[ show edit update destroy ]
  before_action :room_ownership, only: %i[ edit update destroy ]
  before_action :set_locations, only: %i[ new edit ]
  before_action :validate_images, only: %i[ create ]

  def index
    @rooms = Room.all.includes(:location).order(updated_at: :desc)
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
      redirect_to new_room_path, alert: "Room was not updated.", status: :unprocessable_entity
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
      if image.size > 4194304
        redirect_to new_room_path, alert: "Please upload images less than 4MB in size.", status: :unprocessable_entity
      elsif !image.content_type.in?(%w[ image/jpeg image/png ])
        redirect_to new_room_path, alert: "Please upload images in jpeg or png format.", status: :unprocessable_entity
      end
    end
  end
end
