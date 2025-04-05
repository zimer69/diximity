class AddConnectionIdToChats < ActiveRecord::Migration[8.0]
  def change
    add_column :chats, :connection_id, :bigint
    add_index :chats, :connection_id, unique: true
  end
end
