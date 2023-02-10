class Review < ApplicationRecord
  validates :rating, :title, :comment, presence: true
  validates :rating, numericality: { only_integer: true, in: 1..5 }
  belongs_to :room
  belongs_to :occupant
end
