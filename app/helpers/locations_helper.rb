module LocationsHelper
  # in: [name, code]
  # out: [name, code--name--type]
  def append_code array, type=""
    array.each do |item|
      item[1] += "--#{item[0]}"
      item[1] += "--#{type}" unless type.blank?
    end
  end

  # in: [{}, {}]
  # out: [[name, code], [name, code]]
  def name_and_code response
    response.collect { |item| [item["name"], item["code"]]}
  end

  def query_string location
    name = location.name
    street = location.street
    barangay = location.barangay
    city = location.city
    (name + street + barangay + city).gsub(" ", "+")
  end

  def address_string location
    unit = location.unit
    street = location.street
    barangay = location.barangay
    city = location.city
    "#{unit}, #{street}, #{barangay}, #{city}"
  end

  def param_to_latitude lat
    return nil if lat.nil?
    lat.count("^0-9.") == 0 and lat.to_d.between?(-90,90) ? lat.to_f : nil
  end

  def param_to_longitude lng
    return nil if lng.nil?
    lng.count("^0-9.") == 0 and lng.to_d.between?(-180,180) ? lng.to_f : nil
  end
end