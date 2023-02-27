module MapsHelper
  def coordinates_string location
    location.slice(:latitude, :longitude).values.join(",")
  end

  def merge_fields rooms
    rooms.map do |room|
      location = room.location.slice(:name, :latitude, :longitude)
      location[:location_name] = location.delete(:name)
      room = room.slice(:id, :name, :rent)
      room.merge(location)
    end
  end

  def geocode_param param
    return [14.5995124, 120.9842195] if param.blank?
    results = Geocoder.search(param)
    results.present? ? results.first.coordinates : [14.5995124, 120.9842195]
  end
end
