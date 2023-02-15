class Room < ApplicationRecord
  validates :name, :description, :rent, :capacity, :vacancies, presence: true
  delegate :owner, to: :location
  belongs_to :location
  has_many :reviews, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  def image_as_thumbnail image
    return unless image.content_type.in?(%w[ image/jpeg image/png ])
    image.variant(resize_to_limit: [400, 400]).processed
  end
end
