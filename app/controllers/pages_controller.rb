class PagesController < ApplicationController
  before_action :authenticate_owner!, only: %i[ dashboard ]

  def home
  end

  def options
  end

  def dashboard
    @locations = current_owner.locations
    @rooms = current_owner.rooms.includes(:location)
    @schedule = current_owner.schedule
  end

  def map
    location = Location.find(params[:location_id])

    render partial: "pages/dashboard/map", locals: { query: location.query } 
  end
end
