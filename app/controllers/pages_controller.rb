class PagesController < ApplicationController
  before_action :authenticate_owner!, only: %i[ dashboard ]

  def home
  end

  def options
  end

  def dashboard
    @locations = current_owner.locations
    @rooms = current_owner.rooms.includes(:location)
  end
end
