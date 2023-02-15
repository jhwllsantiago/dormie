class RoomsController < ApplicationController
  before_action :authenticate_owner!, except: %i[ index show ]
  before_action :set_room, only: %i[ show edit update destroy ]
  before_action :room_ownership, only: %i[ edit update destroy ]
  before_action :set_locations, only: %i[ new edit ]

  def index
    @rooms = Room.all.includes(:location)
  end

  def show
    @tags = Tag.where(id: @room.tags)
  end

  def new
    @tags = Tag.names_to_hash
    @room = Room.new
  end

  def create
    @room = Room.new(room_params.except(:location))
    @room.location = Location.find(room_params[:location])

    if !content_type_valid?
      redirect_to new_room_path, alert: "Please upload images in jpg or png format.", status: :unprocessable_entity
    elsif @room.save
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
    redirect_to new_room_path, notice: "Room was successfully deleted."
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

  def content_type_valid?
    return true if room_params[:images].nil?
    room_params[:images].each do |image|
      return false unless image.content_type.in? %w[ image/jpeg image/png ]
    end
    true
  end
end
