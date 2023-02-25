module MapsHelper
  def coordinates_string location
    location.slice(:latitude, :longitude).values.join(",")
  end
end
