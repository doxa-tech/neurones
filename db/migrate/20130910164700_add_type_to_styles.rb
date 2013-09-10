class AddTypeToStyles < ActiveRecord::Migration
  def change
  	add_column :g_styles, :theme, :boolean
  end
end
