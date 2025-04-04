class AddUniqueIndexToConnections < ActiveRecord::Migration[8.0]
  def change
    # Adding unique index to prevent duplicate connections (user_id, connected_user_id) direction
    add_index :connections, [:user_id, :connected_user_id], unique: true
    
    # Adding reverse direction unique index to prevent duplicate connections (connected_user_id, user_id)
    add_index :connections, [:connected_user_id, :user_id], unique: true
  end
end