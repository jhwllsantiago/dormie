module RoomsHelper
  include Pagy::Frontend

  def notify?
    params[:page].blank? and params[:commit] == "Search"
  end

  def allowed_to_write_review?
    occupant_signed_in? and @room.owner.email != current_occupant&.email
  end
end
