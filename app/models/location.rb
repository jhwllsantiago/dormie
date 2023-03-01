class Location < ApplicationRecord
  validates :name, :address_line, :city, :province, :query, presence: true
  geocoded_by :query
  belongs_to :owner
  has_many :rooms, dependent: :destroy
  attribute :latitude, :float
  attribute :longitude, :float
end
