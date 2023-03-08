module RoomsHelper
  include Pagy::Frontend

  def notify?
    params[:page].blank? and params[:commit] == "Search"
  end
end
