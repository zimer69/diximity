class ConnectionsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!
  before_action :find_connection, only: %i[accept reject]
  before_action :set_connection_params, only: %i[create]
  
  def index
    @pagy, @connections = pagy(
      Connection.where("user_id = ? OR connected_user_id = ?", current_user.id, current_user.id)
                .where(status: "accepted")
                .includes(:user, :connected_user)
    )
  end

  def create
    puts '*' * 5000
    puts params.inspect
    connection = current_user.connections.build(
      user_id: current_user.id,
      connected_user_id: params[:user_id],
      status: :pending
    )

    if connection.save
      Notification.create!(
        user: connection.connected_user,
        message: "#{current_user.name} sent you a connection request.",
        notification_type: "connection_request",
        connection_id: connection.id,
        read: false
      )
      redirect_back fallback_location: root_path, notice: "Connection request sent."
    else
      redirect_back fallback_location: root_path, alert: "Could not send request."
    end
  end

  def accept
    if @connection.connected_user == current_user
      @connection.update(status: :accepted)
      Notification.create!(
        user: @connection.user,
        message: "#{current_user.name} accepted your connection request.",
        notification_type: "connection_accepted",
        connection_id: @connection.id,
        read: false
      )
      redirect_back fallback_location: root_path, notice: "Connection accepted!"
    else
      redirect_back fallback_location: root_path, alert: "Not authorized."
    end
  end

  def reject
    if @connection.connected_user == current_user
      @connection.destroy
      redirect_back fallback_location: root_path, notice: "Connection rejected."
    else
      redirect_back fallback_location: root_path, alert: "Not authorized."
    end
  end

  def destroy
    puts '*' * 5000
    connection = Connection.find_by(user_id: current_user.id, connected_user_id: params[:id]) ||
                 Connection.find_by(user_id: params[:id], connected_user_id: current_user.id)
    if connection
      connection.destroy
      redirect_back fallback_location: root_path, notice: "Connection removed."
    else
      redirect_back fallback_location: root_path, alert: "Connection not found."
    end
  end

  private

  def find_connection
    @connection = Connection.find(params[:id])
  end

  def set_connection_params
    @connection_params = params.permit(:user_id)
  end
end
