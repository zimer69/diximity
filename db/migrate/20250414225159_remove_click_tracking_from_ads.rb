class RemoveClickTrackingFromAds < ActiveRecord::Migration[8.0]
  def change
    remove_column :ads, :clicks, :integer
    remove_column :ads, :page_clicks, :jsonb
    remove_column :ads, :user_clicks, :jsonb
    remove_column :ads, :last_clicked_at, :datetime
  end
end
