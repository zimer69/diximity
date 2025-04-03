class Connection < ApplicationRecord
  enum :status, %i[pending accepted]
  
  belongs_to :user
  belongs_to :connected_user, class_name: "User"
  has_many :notifications, dependent: :destroy

  after_initialize :set_default_status, if: :new_record?
  after_update :mark_notification_as_read, if: :saved_change_to_status?

  private

  def set_default_status
    self.status ||= "pending"
  end

  def mark_notification_as_read
    notification = self.notifications.find_by(notification_type: "connection_request")
    notification.mark_as_read if notification.present?
  end
end
