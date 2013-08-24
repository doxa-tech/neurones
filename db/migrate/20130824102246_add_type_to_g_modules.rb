class AddTypeToGModules < ActiveRecord::Migration
  def change
  	add_column :g_modules, :module_type_id, :integer
  	add_column :g_modules, :module_id, :integer
  	add_column :g_modules, :description, :text
  	add_column :g_modules, :image, :string

  	add_index :g_modules, :module_type_id
  	add_index :g_modules, :module_id
  end
end
