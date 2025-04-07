class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: [:show]

  def index
    @chats = current_user.chats.includes(:connection, :messages).order(updated_at: :desc)
  end

  def show
    @chats = current_user.chats.includes(:connection, :messages).order(updated_at: :desc)
    @message = Message.new
    @messages = @chat.messages.includes(:user).order(created_at: :asc)
    @message = Message.new
  end

  def create
    connection = Connection.find(params[:connection_id])
    @chat = Chat.find_or_create_by(connection_id: connection.id)
    redirect_to chat_path(@chat)
  end

  private

  def set_chat
    @chat = current_user.chats.find(params[:id])
  end
end
