class Location < ApplicationRecord
  validates :name, :address, :barangay, :city, presence: true
  has_many :rooms, dependent: :destroy
  has_many :owners, -> { distinct }, through: :rooms
end
