class AddArticleIdToMercuryImage < ActiveRecord::Migration
  def change
  	add_column :mercury_images, :article_id, :integer
  	add_index :mercury_images, :article_id
  end
end
