class Room < ApplicationRecord
  validates :name, :description, :rent, :capacity, :vacancies, presence: true
  delegate :owner, to: :location
  belongs_to :location
  has_many :reviews, dependent: :destroy
end
