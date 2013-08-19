class RenameGroupTables < ActiveRecord::Migration
  def change
  	rename_table :group_groups, :groups
  	rename_table :group_comp_groups, :g_comp_groups
  	rename_table :group_comp_pages, :g_comp_pages
  	rename_table :group_modules, :g_modules
  	rename_table :group_pages, :g_pages
  end
end
