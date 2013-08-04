class CreateGroupModules < ActiveRecord::Migration
  def change
    create_table :group_modules do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
