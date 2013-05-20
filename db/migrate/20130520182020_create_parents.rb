class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.belongs_to :user
      t.belongs_to :parent

      t.timestamps
    end
    add_index :parents, :user_id
    add_index :parents, :parent_id
  end
end
