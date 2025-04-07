class Chat < ApplicationRecord
    belongs_to :connection
    has_many :messages, dependent: :destroy

    has_many :chat_users, -> { distinct }, through: :connection, source: :user
    has_many :connected_chat_users, -> { distinct }, through: :connection, source: :connected_user

    def users
        User.where(id: [connection.user_id, connection.connected_user_id])
    end

    validates :connection_id, presence: true

    def other_user(current_user)
        connection.user_id == current_user.id ? connection.connected_user : connection.user
    end
end
