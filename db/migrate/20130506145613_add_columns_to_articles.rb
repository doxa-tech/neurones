class AddColumnsToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :subtitle, :string
  	add_column :articles, :likes, :integer, default: 0
  end
end
