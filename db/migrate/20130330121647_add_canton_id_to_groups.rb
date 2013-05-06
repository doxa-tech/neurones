class AddCantonIdToGroups < ActiveRecord::Migration
  def change
  	remove_column :groups, :canton 
  	add_column :groups, :canton_id, :integer
  end
end
