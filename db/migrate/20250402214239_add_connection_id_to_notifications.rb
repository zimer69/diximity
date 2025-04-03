class AddConnectionIdToNotifications < ActiveRecord::Migration[8.0]
  def change
    add_column :notifications, :connection_id, :bigint, null: true
    add_index :notifications, :connection_id
  end
end
