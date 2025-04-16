class CreateAdClicks < ActiveRecord::Migration[8.0]
  def change
    create_table :ad_clicks do |t|
      t.references :ad, null: false, foreign_key: true
      t.datetime :clicked_at
      t.bigint :user_id
      t.string :page

      t.timestamps
    end
  end
end
