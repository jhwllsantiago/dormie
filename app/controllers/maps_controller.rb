class MapsController < ApplicationController
  before_action :authenticate_owner!, except: %i[ results_map ]
  before_action :set_map_params, :set_locations, only: %i[ results_map ]

  def location_map
    location = Location.find(params[:location_id])
    render partial: "maps/location_map", locals: { query: location.coordinates_string }
  end

  def marker_map
    @params = location_params
    @center = Location.geocode_place(location_params)
  end

  def results_map
    if @locations.blank?
      flash.now.alert = "No rooms found."
    else
      flash.now.notice = "#{view_context.pluralize(@room_count, "room")} found."
    end
  end

  private
  def location_params
    params.fetch(:location, {}).permit!
  end

  def search_params
    params.permit(:place, :distance, :rent, :commit)
  end

  def set_map_params
    @place = search_params[:place]
    @center = Location.geocode_place(@place)
    @distance = search_params[:distance]&.to_i || 20
    @rent = search_params[:rent]&.to_f || 20000
  end

  def set_locations
    @locations = Location.with_nearby_rooms(@place, @distance)
    @locations, @room_count = Location.filter_and_count(@locations, @rent)
  end
end
