class CreateGroupCompPages < ActiveRecord::Migration
  def change
    create_table :group_comp_pages do |t|
      t.belongs_to :page
      t.belongs_to :comp_group
      t.integer :order
    end
    add_index :group_comp_pages, :page_id
    add_index :group_comp_pages, :comp_group_id
  end
end
