class AddColumnToArticles < ActiveRecord::Migration

  def change
  	add_column :articles, :author, :string
  	add_column :articles, :category, :string
  end
end
