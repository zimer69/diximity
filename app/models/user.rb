class User < ApplicationRecord
  acts_as_paranoid

  has_one_attached :profile_picture
  has_one_attached :background_image
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address, update_only: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_initialize :build_address, if: -> { new_record? && address.nil? }
  validates :name, :bio, :specialty, presence: true
end
