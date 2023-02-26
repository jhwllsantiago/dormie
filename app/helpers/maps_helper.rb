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

  def geographic_center rooms
    points = rooms.map do |room|
       [room[:latitude], room[:longitude]]
    end
    Geocoder::Calculations.geographic_center(points)
  end
end
