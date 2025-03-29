class AddBackgroundImageAndSummaryToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :background_image_url, :string
    add_column :users, :profile_summary, :text
  end
end
