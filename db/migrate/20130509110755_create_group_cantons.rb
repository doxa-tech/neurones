class CreateGroupCantons < ActiveRecord::Migration
  def change
    create_table :group_cantons do |t|
    	t.string :name

      t.timestamps
    end
  end
end
