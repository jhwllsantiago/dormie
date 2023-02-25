class MapsController < ApplicationController
  include MapsHelper
  before_action :authenticate_owner!

  def location_map
    location = Location.find(params[:location_id])
    render partial: "maps/location_map", locals: { query: coordinates_string(location) } 
  end

  def location_preview
    @target = params[:target]
    @query = params[:query]
    respond_to do |f|
      f.turbo_stream
    end
  end

  def marker_forward_geocoding
    @params = location_params
  end

  private
  def location_params
    params.fetch(:location, {}).permit!
  end
end
