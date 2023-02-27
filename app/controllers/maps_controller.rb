class MapsController < ApplicationController
  include MapsHelper
  before_action :authenticate_owner!, except: %i[ results_map ]
  before_action :set_map_params, only: %i[ results_map ]

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
    if search_params[:near]
      locations = Location.near(search_params[:near], @distance)
      if locations.present?
        @rooms = Room.where(location: locations.pluck(:id)).select { |room| @rent >= room.rent }
      end
    end
    
    if @rooms.blank?
      flash.now.alert = "No rooms found."
    else
      flash.now.notice = "#{view_context.pluralize(@rooms.size, "room")} found."
      @rooms = merge_fields(@rooms)
    end
  end

  private
  def location_params
    params.fetch(:location, {}).permit!
  end

  def search_params
    params.permit(:near, :distance, :rent)
  end

  def set_map_params
    @rooms = []
    @center = geocode_param(params[:near])
    @distance = search_params[:distance]&.to_i || 10
    @rent = search_params[:rent]&.to_f || 10000
  end
end
