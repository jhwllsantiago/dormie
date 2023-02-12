module Psgc
  class Client
    def self.cities_of_region region_code
      Request.call("/regions/#{region_code}/cities-municipalities.json")
    end

    def self.sub_of_region region_code
      Request.call("/regions/#{region_code}/sub-municipalities.json")
    end

    def self.barangays_of_type type, city_code
      Request.call("/#{type}/#{city_code}/barangays.json")
    end
  end
end