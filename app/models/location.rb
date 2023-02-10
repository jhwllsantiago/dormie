class Location < ApplicationRecord
  validates :name, :address, :barangay, :city, presence: true
  has_many :rooms
end
