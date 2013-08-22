class CreateGImages < ActiveRecord::Migration
  def change
    create_table :g_images do |t|
      t.string :name
      t.string :image
      t.belongs_to :group

      t.timestamps
    end
    add_index :g_images, :group_id
  end
end
