class Location < ApplicationRecord
  validates :name, :unit, :address_line, :city, :province, :query, presence: true
  geocoded_by :query
  after_save :geocode if :coordinate_blank?
  belongs_to :owner
  has_many :rooms, dependent: :destroy
  attribute :latitude, :float
  attribute :longitude, :float

  def coordinate_blank?
    this.latitude.blank? or this.longitude.blank?
  end
end
