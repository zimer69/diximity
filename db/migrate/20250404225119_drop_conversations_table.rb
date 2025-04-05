class DropConversationsTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :conversations  
  end
end
