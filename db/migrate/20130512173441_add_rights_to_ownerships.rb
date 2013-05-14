class AddRightsToOwnerships < ActiveRecord::Migration
  def change
  	add_column :ownerships, :right_read, :boolean
  	add_column :ownerships, :right_create, :boolean
  	add_column :ownerships, :right_update, :boolean
  	add_column :ownerships, :right_delete, :boolean
  	add_column :ownerships, :id_element, :integer
  end
end
