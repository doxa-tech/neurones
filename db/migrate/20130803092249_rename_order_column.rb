class RenameOrderColumn < ActiveRecord::Migration
  def change
    rename_column :group_comp_pages, :order, :module_order
  end
end
