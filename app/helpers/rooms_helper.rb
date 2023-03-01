module RoomsHelper
  include Pagy::Frontend
  
  def extract_sort_option param
    a, b = param&.split("-")
    if a.nil? or b.nil? or %w[ distance rent updated_at ].exclude?(a) or %w[ asc desc ].exclude?(b)
      { updated_at: :desc }
    else
      Hash[a.to_sym, b.to_sym]
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
