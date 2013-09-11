class AddImageAndDescriptionToStyle < ActiveRecord::Migration
  def change
  	add_column :g_styles, :image, :string
  	add_column :g_styles, :description, :text
  end
end
