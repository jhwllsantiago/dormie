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
end
