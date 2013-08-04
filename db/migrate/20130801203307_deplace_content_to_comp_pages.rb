class DeplaceContentToCompPages < ActiveRecord::Migration
  def change
    remove_column :group_modules, :content
    add_column :group_comp_pages, :content, :text
  end
end
