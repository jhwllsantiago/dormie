class Location < ApplicationRecord
  validates :name, :unit, :address_line, :city, :province, :query, presence: true
  geocoded_by :query
  after_validation :geocode if :coordinate_blank?
  belongs_to :owner
  has_many :rooms, dependent: :destroy

  def coordinate_blank?
    latitude.blank? or longitude.blank?
  end
end
