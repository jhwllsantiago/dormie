module LocationsHelper
  def query_string params
    params.slice(:name, :city, :province).values.compact.join(" ")
  end

  def address_string params
    params.slice(:unit, :address_line ,:city, :province).values.compact.join(", ")
  end

  def param_to_latitude lat
    return nil if lat.blank?
    lat.count("^0-9.") == 0 and lat.to_d.between?(-90,90) ? lat.to_f : nil
  end

  def param_to_longitude lng
    return nil if lng.blank?
    lng.count("^0-9.") == 0 and lng.to_d.between?(-180,180) ? lng.to_f : nil
  end
end