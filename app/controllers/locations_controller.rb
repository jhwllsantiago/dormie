class LocationsController < ApplicationController
  before_action :authenticate_owner!

  def new
    @location = Location.new
  end

  def create
    
  end

  private
  def location_params
    params.require(:location).permit(:name, :address, :barangay, :city, :long, :lat)
  end
end