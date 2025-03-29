class RemoveBackgroundImageUrlFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :background_image_url, :string
  end
end
