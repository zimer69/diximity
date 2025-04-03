class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :connection, optional: true

  scope :unread, -> { where(read: false) }
  
  validates :message, presence: true

  def mark_as_read
    update(read: true)
  end
end
