class AddUidToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :uid, :integer
  	add_index :users, :uid
  end
end
