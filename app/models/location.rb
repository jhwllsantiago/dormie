class Location < ApplicationRecord
  validates :name, :address, :barangay, :city, :province, presence: true
  has_many :rooms
end
