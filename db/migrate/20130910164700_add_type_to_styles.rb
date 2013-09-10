class AddTypeToStyles < ActiveRecord::Migration
  def change
  	add_column :g_styles, :type, :boolean
  end
end
