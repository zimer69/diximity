class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  after_commit :broadcast_message

  def broadcast_message
    # Broadcast to the sender's stream
    broadcast_append_to(
      [ chat, "messages", user_id ],
      target: "messages",
      partial: "messages/message",
      locals: { message: self, current_user_id: user_id }
    )

    # Broadcast to the receiver's stream
    other_user_id = chat.connection.user_id == user_id ? chat.connection.connected_user_id : chat.connection.user_id
    broadcast_append_to(
      [ chat, "messages", other_user_id ],
      target: "messages",
      partial: "messages/message",
      locals: { message: self, current_user_id: other_user_id }
    )
  end
end