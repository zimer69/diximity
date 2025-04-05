class RemoveNameAndDescriptionFromChats < ActiveRecord::Migration[8.0]
  def change
    remove_column :chats, :name, :string
    remove_column :chats, :description, :text
  end
end
