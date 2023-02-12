class LocationsController < ApplicationController
  include LocationsHelper
  before_action :authenticate_owner!

  def new
    @location = Location.new
    @cities = get_cities
  end

  def create
    @location = Location.new(location_params)
    @location.barangay = @location.barangay.split("--")[1]
    @location.city = @location.city.split("--")[1]

    if @location.save
      redirect_to new_room_path, notice: "Location was successfully added."
    else
      redirect_to locations_new_url, alert: "Location was not added.", status: :unprocessable_entity
    end
  end

  # turbo-stream for GET /locations/select-barangay
  def select_barangay
    @target = params[:target]
    @barangays = get_barangays
    respond_to do |f|
      f.turbo_stream
    end
  end

  private
  def location_params
    params.require(:location).permit(:name, :address, :barangay, :city, :long, :lat)
  end

  def get_cities
    response_cm = Psgc::Client.cities_of_region("130000000")
    response_sm = Psgc::Client.sub_of_region("130000000")
    
    cm = name_and_code(response_cm)
    sm = name_and_code(response_sm)
    append_code(cm, "cities-municipalities").concat append_code(sm, "sub-municipalities")
  end

  def get_barangays
    code, name, type = params[:city].split("--")
    response = Psgc::Client.barangays_of_type(type, code)
    collection = name_and_code(response)
    append_code(collection)
  end
end