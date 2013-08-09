class CreateGroupModules < ActiveRecord::Migration
  def change
    create_table :group_modules do |t|
      t.string :name

      t.timestamps
    end
  end
end
