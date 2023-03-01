class Owner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  validates :name, presence: true
  validates :contact, presence: true, format: { with: /\A09\d{9}\z/ }
  has_many :locations, dependent: :destroy
  has_many :rooms, through: :locations
  enum :status, { standard: 0, partner: 1, inactive: 2 }
end
