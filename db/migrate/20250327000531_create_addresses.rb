class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :tax_phone_number
      t.float :latitude
      t.float :longitude
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :addresses, :deleted_at
  end
end
