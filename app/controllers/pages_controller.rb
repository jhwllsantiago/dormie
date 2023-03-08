class PagesController < ApplicationController
  before_action :authenticate_owner!, only: %i[ dashboard ]

  def home
  end

  def options
  end

  def dashboard
    @locations = current_owner.locations.order(:name)
    @rooms = current_owner.rooms.includes(:location).order("locations.name")
    @query = @locations.first.coordinates_string if @locations.present?
  end
end
