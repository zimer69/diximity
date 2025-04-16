class User < ApplicationRecord
  acts_as_paranoid

  has_one_attached :profile_picture
  has_one_attached :background_image
  has_one :address, dependent: :destroy
  has_one :calendar, dependent: :destroy

  has_many :connections
  has_many :connected_users, through: :connections, source: :connected_user
  has_many :received_connections, class_name: 'Connection', foreign_key: 'connected_user_id'
  has_many :users_who_connected, through: :received_connections, source: :user
  has_many :notifications
  has_many :messages
  has_many :chats, through: :connections
  has_many :time_slots, dependent: :destroy

  accepts_nested_attributes_for :address, update_only: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_initialize :build_address, if: -> { new_record? && address.nil? }
  after_create :create_default_calendar
  validates :name, :bio, :specialty, presence: true

  attribute :is_active, :boolean, default: true

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }

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

  def connections
    Connection.where("user_id = ? OR connected_user_id = ?", self.id, self.id)
  end

  def chats
    @chats = Chat.joins(:connection)
                .where("connections.user_id = ? OR connections.connected_user_id = ?", self.id, self.id)
                .distinct
  end

  def soft_delete
    update(deleted_at: Time.current)
  end

  def active_for_authentication?
    super && !deleted_at
  end

  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  private

  def create_default_calendar
    create_calendar!
  end
end