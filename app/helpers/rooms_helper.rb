module RoomsHelper
  include Pagy::Frontend

  def notify?
    params[:page].blank? and params[:commit] == "Search"
  end

  def allowed_to_write_review?
    occupant_signed_in? and @room.owner.email != current_occupant&.email
  end

  def image_link_to_images room, image
    body = image_tag(room.image_variant(image, 800, 450))
    url = room_images_path(room, active: image.id)
    options = {
      data: { turbo_frame: "room_images_frame", action: "click->room#showImages" }
    }
    
    link_to(body, url, options)
  end

  def options_for_location location
    {
      place: "#{location.latitude}, #{location.longitude}",
      distance: 1,
      sort: "distance-asc"
    }
  end
end
