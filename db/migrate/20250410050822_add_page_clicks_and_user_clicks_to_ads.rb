class AddPageClicksAndUserClicksToAds < ActiveRecord::Migration[8.0]
  def change
    add_column :ads, :page_clicks, :jsonb
    add_column :ads, :user_clicks, :jsonb
    remove_column :ads, :user_id
    remove_column :ads, :page
  end
end
