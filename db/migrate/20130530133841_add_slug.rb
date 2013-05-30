class AddSlug < ActiveRecord::Migration
  def change
  	add_column :articles, :slug, :string
  	add_column :events, :slug, :string
  	add_column :galleries, :slug, :string
  	add_column :users, :slug, :string
  	add_index :articles, :slug
  	add_index :events, :slug
  	add_index :galleries, :slug
  	add_index :users, :slug
  end
end
