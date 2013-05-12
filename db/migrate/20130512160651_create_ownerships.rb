class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.belongs_to :element
      t.belongs_to :user
      t.belongs_to :right
      t.belongs_to :ownership_type

      t.timestamps
    end
    add_index :ownerships, :element_id
    add_index :ownerships, :user_id
    add_index :ownerships, :right_id
    add_index :ownerships, :ownership_type_id
  end
end
