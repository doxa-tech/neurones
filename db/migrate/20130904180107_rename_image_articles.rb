class RenameImageArticles < ActiveRecord::Migration
  def change
  	remove_column :articles, :image_id
  	add_column :articles, :image, :string
  end
end
