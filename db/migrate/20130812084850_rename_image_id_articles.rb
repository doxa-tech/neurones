class RenameImageIdArticles < ActiveRecord::Migration
  def change
  	rename_column :articles, :mercury_image_id, :image_id
  end
end
