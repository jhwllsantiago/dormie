class Room < ApplicationRecord
  validates :name, :description, :rent, :capacity, :vacancies, presence: true
  validates :capacity, :vacancies, numericality: { only_integer: true, greater_than: 0 }
  validates :rent, numericality: { only_numeric: true, in: 1000..20000 }
  delegate :owner, to: :location
  belongs_to :location
  has_many :reviews, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  def image_as_thumbnail image, width=400, height=400
    # libvips is required for image variants
    # disable line 11 if production server supports installation of libvips
    return image if Rails.env.production?
    return unless image.content_type.in?(%w[ image/jpeg image/png ])
    image.variant(resize_to_limit: [width, height]).processed
  end
end
