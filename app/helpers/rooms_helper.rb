module RoomsHelper
  include Pagy::Frontend
  
  def extract_sort_option param
    order = param&.split("-")&.map(&:to_sym)
    if param.blank? or %i[ distance rent updated_at ].exclude?(order[0]) or %i[ asc desc ].exclude?(order[1])
      [:updated_at, :desc]
    else
      order
    end
  end

  def rentable_room_ids locations, rent
    locations.flat_map do |location|
      location.rooms.flat_map do |room|
        room.id if rent >= room.rent
      end
    end.compact
  end
end
