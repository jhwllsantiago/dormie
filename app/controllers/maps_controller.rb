class MapsController < ApplicationController
  include MapsHelper
  before_action :authenticate_owner!, except: %i[ results_map ]
  before_action :set_map_params, :set_locations, only: %i[ results_map ]

  def location_map
    location = Location.find(params[:location_id])
    render partial: "maps/location_map", locals: { query: coordinates_string(location) } 
  end

  def marker_map
    @params = location_params
    @center = MapsHelper.geocode_param(location_params)
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
    @center = MapsHelper.geocode_param(params[:place])
    @distance = search_params[:distance]&.to_i || 20
    @rent = search_params[:rent]&.to_f || 20000
  end

  def set_locations
    @locations = Location.with_nearby_rooms(@place, @distance)
    @locations, @room_count = filter_and_count
  end
end
