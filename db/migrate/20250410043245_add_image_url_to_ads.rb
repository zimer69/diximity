class AddImageUrlToAds < ActiveRecord::Migration[8.0]
  def change
    add_column :ads, :image_url, :string
  end
end
