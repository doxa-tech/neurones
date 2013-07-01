class ModifyEvents < ActiveRecord::Migration
  def change
  	remove_column :events, :theme
  	remove_column :events, :lieu
  	remove_column :events, :events_type_id
  	remove_column :events, :info
  	remove_column :events, :remarque
  	add_column :events, :content, :text
  	add_column :events, :title, :string
  end
end
