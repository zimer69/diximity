class Connection < ApplicationRecord
  enum :status, %i[pending accepted]
  
  belongs_to :user
  belongs_to :connected_user, class_name: "User"
  has_many :notifications

  after_initialize :set_default_status, if: :new_record?
  before_destroy :mark_notification_as_read
  after_update :mark_notification_as_read, if: :saved_change_to_status?

  private

  def set_default_status
    self.status ||= "pending"
  end

  def mark_notification_as_read
    self.notifications.last.mark_as_read
  end
end
