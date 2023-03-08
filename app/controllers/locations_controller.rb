class LocationsController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_coordinates, only: %i[ new ]

  def new
    @location = Location.new(location_params)
  end

  def create
    @location = Location.new(location_params)
    @location.build_attributes(location_params)
    @location.owner = current_owner

    if @location.save
      redirect_to dashboard_path, notice: "Location was successfully added."
    else
      redirect_to new_location_path, alert: "Location was not added.", status: 302
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@location) }
      format.html         { redirect_to dashboard_path }
    end
  end

  private
  def location_params
    params.fetch(:location, {}).permit(:name, :unit, :address_line, :city, :province, :latitude, :longitude)
  end

  def set_coordinates
    @latitude, @longitude = Location.coordinates(location_params)
  end
end