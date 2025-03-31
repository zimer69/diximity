class AddUserIdToAddresses < ActiveRecord::Migration[8.0]
  def change
    add_reference :addresses, :user, null: true, foreign_key: true
  end
end
