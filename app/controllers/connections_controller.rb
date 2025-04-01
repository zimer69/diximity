class ConnectionsController < ApplicationController
  before_action :authenticate_user!

  def create
    connection = current_user.connections.build(connected_user_id: params[:user_id], status: "pending")
    puts '*' * 200
    puts params
    if connection.save
      redirect_back fallback_location: root_path, notice: "Connection request sent."
    else
      redirect_back fallback_location: root_path, alert: "Could not send request."
    end
  end

  def update
    connection = Connection.find(params[:id])
    if connection.connected_user == current_user
      connection.update(status: params[:status])
      redirect_back fallback_location: root_path, notice: "Connection #{params[:status]}."
    else
      redirect_back fallback_location: root_path, alert: "Not authorized."
    end
  end

  def destroy
    other_user = User.find(params[:user_id])

    connection = Connection.find_by(user_id: current_user.id, connected_user_id: other_user.id) ||
                Connection.find_by(user_id: other_user.id, connected_user_id: current_user.id)

    if connection
      connection.destroy
      redirect_to user_path(other_user), notice: "Connection removed."
    else
      redirect_to user_path(other_user), alert: "Connection not found."
    end
  end
end
