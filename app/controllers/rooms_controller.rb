class RoomsController < ApplicationController
  before_action :authenticate_owner!, except: %i[ index show ]
  before_action :set_room, only: %i[ show edit update destroy ]

  def index

  end

  def show
    @tags = Tag.where(id: @room.tags)
  end

  def new
    @tags = Tag.names_to_hash
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.owner = current_owner
    @room.location = Location.first

    if @room.save
      redirect_to room_url(@room), notice: "Room was successfully created."
    else
      redirect_to new_room_path, alert: "Room was not created.", status: :unprocessable_entity
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :rent, :capacity, :vacancies, :description, tags: [])
  end

end
