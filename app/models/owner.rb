class Owner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  validates :name, presence: true
  has_many :rooms
  has_many :locations, through: :rooms
  has_one :schedule
  enum :status, { unverified: 0, verified: 1, partner: 2, inactive: 3 }
end
