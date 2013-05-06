class AddIndexToId < ActiveRecord::Migration
  def change
  	add_index :events, :image_id
  	add_index :events, :events_type_id
  	add_index :groups, :canton_id
  	add_index :paintings, :gallery_id
  	add_index :users, :level_id
  end
end
