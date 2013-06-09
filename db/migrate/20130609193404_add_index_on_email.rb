class AddIndexOnEmail < ActiveRecord::Migration
  def change
  	remove_index :users, :name
  	add_index :users, :email
  end
end
