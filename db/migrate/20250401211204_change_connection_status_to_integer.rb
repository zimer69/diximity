class ChangeConnectionStatusToInteger < ActiveRecord::Migration[6.1]
  def change
    change_column_default :connections, :status, nil
    change_column :connections, :status, :integer, using: 'status::integer'
    change_column_default :connections, :status, 0  # 0 = pending
  end
end
