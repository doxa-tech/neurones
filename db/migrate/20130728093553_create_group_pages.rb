class CreateGroupPages < ActiveRecord::Migration
  def change
    create_table :group_pages do |t|
      t.text :content
      t.string :url
      t.integer :order
      t.string :name
      t.belongs_to :group

      t.timestamps
    end
    add_index :group_pages, :group_id
  end
end
