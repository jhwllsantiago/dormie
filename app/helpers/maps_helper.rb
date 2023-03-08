module MapsHelper
  def coordinates_string location
    location.slice(:latitude, :longitude).values.join(",")
  end

  def filter_and_count
    room_count = 0
    locations = @locations.map do |location|
      rooms = location.rooms.where(rent: ..@rent).to_a
      room_count += rooms.count
      location = location.serializable_hash
      location["rooms"] = rooms
      location
    end.to_a.select { |location| location["rooms"].present? }
    [locations, room_count]
  end

  def self.geocode_param param
    return [14.5995124, 120.9842195] if param.blank?
    param = param.values.compact.join(" ") if param.kind_of?(ActionController::Parameters)
    results = Geocoder.search(param)
    results.present? ? results.first.coordinates : [14.5995124, 120.9842195]
  end
end
