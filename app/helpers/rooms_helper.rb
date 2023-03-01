module RoomsHelper
  include Pagy::Frontend
  
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
  
  def extract_sort_option param
    order = param&.split("-")&.map(&:to_sym)
    if param.blank? or %i[ distance rent updated_at ].exclude?(order[0]) or %i[ asc desc ].exclude?(order[1])
      [:updated_at, :desc]
    else
      order
    end
  end
end
