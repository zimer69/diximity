class User < ApplicationRecord
  acts_as_paranoid

  has_one_attached :profile_picture
  has_one_attached :background_image
  has_one :address, dependent: :destroy

  has_many :connections
  has_many :connected_users, through: :connections, source: :connected_user
  has_many :received_connections, class_name: 'Connection', foreign_key: 'connected_user_id'
  has_many :users_who_connected, through: :received_connections, source: :user
  has_many :notifications
  has_many :messages

  accepts_nested_attributes_for :address, update_only: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_initialize :build_address, if: -> { new_record? && address.nil? }
  validates :name, :bio, :specialty, presence: true

  def connected_with?(other_user)
    Connection.exists?(
      status: 'accepted',
      user_id: self.id,
      connected_user_id: other_user.id
    ) || Connection.exists?(
      status: 'accepted',
      user_id: other_user.id,
      connected_user_id: self.id
    )
  end
end
