class RenameChatsIdToChatIdInMessages < ActiveRecord::Migration[6.0]
  def change
    # Drop the old index if it exists
    remove_index :messages, name: 'index_messages_on_chats_id' if index_exists?(:messages, :chats_id)

    # Rename the column
    rename_column :messages, :chats_id, :chat_id

    # Add the new index
    add_index :messages, :chat_id, name: 'index_messages_on_chat_id'
  end
end
