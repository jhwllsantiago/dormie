class LocationsController < ApplicationController
  include LocationsHelper
  before_action :authenticate_owner!
  before_action :set_coordinates, only: %i[ new ]

  def new
    @location = Location.new(location_params)
    @query = @coordinates.join(",") if @coordinates.present?
  end

  def create
    @location = Location.new(location_params)
    @location.full_address = address_string(location_params)
    @location.query = query_string(location_params)
    @location.geocode if coordinates_blank?(location_params)
    @location.owner = current_owner

    if @location.save
      redirect_to dashboard_path, notice: "Location was successfully added."
    else
      redirect_to new_location_url, alert: "Location was not added.", status: :unprocessable_entity
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    render partial: "pages/dashboard/locations", locals: { locations: current_owner.locations }
  end

  private
  def location_params
    params.fetch(:location, {}).permit(:name, :unit, :address_line, :city, :province, :latitude, :longitude)
  end

  def set_coordinates
    @latitude = param_to_latitude(location_params[:latitude])
    @longitude = param_to_longitude(location_params[:longitude])
    @coordinates = [@latitude, @longitude].compact
  end
end