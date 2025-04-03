class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_notification, only: [:mark_as_read]

  def index
    @unread_notifications = current_user.notifications.unread.order(created_at: :desc)
    @read_notifications = current_user.notifications.where(read: true).order(created_at: :desc)
  end

  def mark_as_read
    @notification.mark_as_read
    redirect_back fallback_location: root_path
  end

  private

  def find_notification
    @notification = Notification.find(params[:id])
  end
end
