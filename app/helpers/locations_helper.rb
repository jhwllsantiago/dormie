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
end