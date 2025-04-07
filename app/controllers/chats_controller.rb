class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: [:show]

  def index
    @chats = current_user.chats.includes(:connection, :messages).order(updated_at: :desc)
  end

  def show
    @chats = current_user.chats.includes(:connection, :messages).order(updated_at: :desc)
    @message = Message.new
    @messages = @chat.messages.includes(:user).order(created_at: :desc)
    
    # Mark messages from the other user as read
    other_user = @chat.other_user(current_user)
    @chat.messages.where(user: other_user, read: false).update_all(read: true)
  end

  def create
    connection = Connection.find(params[:connection_id])
    @chat = Chat.find_or_create_by(connection_id: connection.id)
    redirect_to chat_path(@chat)
  end

  private

  def set_chat
     @chat = Chat.joins(:connection)
              .where(id: params[:id])
              .where("connections.user_id = ? OR connections.connected_user_id = ?", current_user.id, current_user.id)
              .first
  end   
end
