module RoomsHelper
  
  def shortened_city(city)
    arr = city.split(" ")
    if arr.length == 3
      return "#{arr[2]} #{arr[0]}"
    elsif arr.length == 4
      return "#{arr[2]} #{arr[3]} #{arr[0]}"
    else
      return city
    end
  end
  
end
