class AddMercuryImageIdToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :mercury_image_id, :integer
  	add_index :articles, :mercury_image_id
  	remove_column :articles, :image
  end
end
