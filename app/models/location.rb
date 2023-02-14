class Location < ApplicationRecord
  validates :name, presence: true
  geocoded_by :address
  after_validation :geocode
  belongs_to :owner
  has_many :rooms, dependent: :destroy
end
