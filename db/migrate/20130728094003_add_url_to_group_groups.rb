class AddUrlToGroupGroups < ActiveRecord::Migration
  def change
    add_column :group_groups, :url, :string
    add_column :group_groups, :website_activated, :boolean, default: false
    add_column :group_groups, :style_id, :integer
    
    add_index :group_groups, :style_id
  end
end
