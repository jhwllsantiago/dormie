class Location < ApplicationRecord
  validates :name, :address_line, :city, :province, :full_address, :query, presence: true
  geocoded_by :query
  belongs_to :owner
  has_many :rooms, dependent: :destroy
  attribute :latitude, :float
  attribute :longitude, :float

  def self.order_near place, distance, sort_option
    self.near(place, distance)
      .includes(:rooms)
      .reorder(sort_option)
  end

  def self.near_ids place, distance
    self.near(place, distance, order: false).pluck(:id)
  end

  def build_attributes params
    self.full_address = params.slice(:unit, :address_line ,:city, :province).values.compact.join(", ")
    self.query = params.slice(:name, :city, :province).values.compact.join(" ")
    self.geocode if params[:latitude].blank? or params[:longitude].blank?
  end
end
