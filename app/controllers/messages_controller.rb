class MessagesController < ApplicationController
  before_action :set_chat
  before_action :authenticate_user!

  def create
    if @chat.messages.empty?
      @message = @chat.messages.create(message_params)
      @message.user = current_user
      @message.save!
      redirect_to chat_path(@chat)
    else
      @message = @chat.messages.create(message_params)
      @message.user = current_user
      @message.save!
      other_user = @chat.other_user(current_user)
      @chat.messages.where(user: other_user, read: false).update_all(read: true)
  
      render json: {}, status: :no_content
    end
  end

  def show
    @user = current_user
  end

  private

  def set_chat
    @chat ||= Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content, :chat_id)
  end
end