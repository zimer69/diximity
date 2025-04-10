class CreateAds < ActiveRecord::Migration[8.0]
  def change
    create_table :ads do |t|
      t.string :title
      t.text :content
      t.string :target_url
      t.integer :clicks, default: 0
      t.string :position
      t.string :page
      t.string :specialty
      t.datetime :last_clicked_at
      t.integer :user_id

      t.timestamps
    end
  end
end
