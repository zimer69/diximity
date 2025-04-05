class ChatsController < ApplicationController
before_action :set_chat, only: [:show]

  def show
  end

  def new 
    @chat = Chat.new        
  end

  def create
    @connection = Connection.find(params[:connection_id])
    @chat = Chat.find_or_create_by(
      connection_id: @connection.id
    )

    redirect_to chat_path(@chat)
  end

  private
  
  def set_chat
    @chat = Chat.find(params.expect(:id))
  end
end
