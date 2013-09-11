class RenameOrderGroupPages < ActiveRecord::Migration
  def change
  	rename_column :group_pages, :order, :page_order
  end
end
