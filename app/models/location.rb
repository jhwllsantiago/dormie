class Location < ApplicationRecord
  validates :name, :address, :barangay, :city, presence: true
  has_many :rooms
  has_many :owners, through: :rooms
end
