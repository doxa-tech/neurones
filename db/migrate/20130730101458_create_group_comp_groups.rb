class CreateGroupCompGroups < ActiveRecord::Migration
  def change
    create_table :group_comp_groups do |t|
      t.belongs_to :group
      t.belongs_to :module
    end
    add_index :group_comp_groups, :group_id
    add_index :group_comp_groups, :module_id
  end
end
