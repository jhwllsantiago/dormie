class MapsController < ApplicationController
  include MapsHelper
  before_action :authenticate_owner!, except: %i[ results_map ]

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

  def marker_map
    @params = location_params
  end

  def results_map
    if params[:query]
      @rooms = Room.joins(:location).where("locations.query ILIKE ?", "%#{params[:query]}%")
      @rooms = Room.includes(:location) if @rooms.blank?
    else
      @rooms = Room.includes(:location)
    end

    @rooms = merge_fields(@rooms)
    @center = geographic_center(@rooms)
  end

  private
  def location_params
    params.fetch(:location, {}).permit!
  end

  def query_params
    params.permit(:query, :nearby, :distance, :max_rent)
  end
end
