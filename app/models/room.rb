class Room < ApplicationRecord
  validates :name, :description, :rent, :capacity, :vacancies, presence: true
  validates :capacity, :vacancies, numericality: { only_integer: true, greater_than: 0 }
  validates :rent, numericality: { only_numeric: true, in: 1000..20000 }
  delegate :owner, to: :location
  belongs_to :location
  has_many :reviews, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  scope :includes_attachments, -> { includes(images_attachments: :blob)
    .includes(images_attachments: { blob: :variant_records }) }

  scope :includes_all, -> { includes(:location).includes_attachments }

  def image_variant image, width=400, height=400
    # libvips is required for image variants
    # uncomment the next line if production server does not support installation of libvips
    # return image if Rails.env.production?
    return unless image.content_type.in?(%w[ image/jpeg image/png ])
    image.variant(resize_to_limit: [width, height]).processed
  rescue
    "image-load-failed.svg"
  end

  def self.default_order
    self.includes(:location).order(updated_at: :desc)
  end

  def self.where_order_maintained room_ids
    self.includes_all
      .where(id: room_ids)
      .order(Arel.sql("position(id::text in '#{room_ids.join(',')}')"))
  end
  
  def self.rentables location_ids, rent, sort_option={}
    self.includes_all
      .where(location: location_ids, rent: ..rent)
      .order(sort_option)
  end

  def self.rentable_ids locations, rent
    locations.flat_map do |location|
      location.rooms.flat_map do |room|
        room.id if rent >= room.rent
      end
    end.compact
  end

  def self.sort_option param
    a, b = param&.split("-")
    if a.blank? or b.blank? or %w[ distance rent updated_at ].exclude?(a) or %w[ asc desc ].exclude?(b)
      { updated_at: :desc }
    else
      Hash[a.to_sym, b.to_sym]
    end
  end
end
