class Location < ApplicationRecord
  validates :name, :address_line, :city, :province, :query, presence: true
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
end
