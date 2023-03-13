class PagesController < ApplicationController
  before_action :authenticate_owner!, only: %i[ dashboard ]

  def home
  end

  def options
  end

  def dashboard
    @locations = current_owner.locations.order(:name)
    @location = Location.find(params[:location]) if params[:location].present?
    @query = @locations.first.coordinates_string if @locations.present?

    if  @location.blank?
      @rooms = current_owner.rooms.includes(:location).order("locations.name")
    else
      @rooms = current_owner.rooms.includes(:location).where(location: @location)
      render partial: "pages/dashboard/rooms", locals: { rooms: @rooms }
    end
  end
end
