class Location < ApplicationRecord
  validates :name, :address_line, :city, :province, :full_address, :query, presence: true
  validates :latitude, numericality: { only_numeric: true, in: -90..90 }
  validates :longitude, numericality: { only_numeric: true, in: -180..180 }
  geocoded_by :query
  belongs_to :owner
  has_many :rooms, dependent: :destroy
  attribute :latitude, :float
  attribute :longitude, :float

  def self.order_near place, distance, sort_option
    self.near(place, distance)
      .includes(:rooms)
      .reorder(sort_option)
  end

  def self.near_ids place, distance
    self.near(place, distance, order: false).pluck(:id)
  end

  def build_attributes params
    self.full_address = params.slice(:unit, :address_line ,:city, :province).values.compact.join(", ")
    self.query = params.slice(:name, :city, :province).values.compact.join(" ")
    self.geocode if params[:latitude].blank? or params[:longitude].blank?
  end

  def self.with_nearby_rooms place, distance
    self.joins(:rooms).group("locations.id")
        .tap { |locations| return locations if place.blank? }
        .near(place, distance)
  end

  def self.coordinates params
    lat = params[:latitude]
    lng = params[:longitude]
    return [nil, nil] if lat.blank? or lng.blank?
    latitude = lat.to_f if lat.count("^0-9.").zero? and lat.to_f.between?(-90,90)
    longitude = lng.to_f if lng.count("^0-9.").zero? and lng.to_f.between?(-180,180)
    [latitude, longitude]
  end
end
