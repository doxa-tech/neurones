class CreateGPaintings < ActiveRecord::Migration
  def change
    create_table :g_paintings do |t|
      t.string :name
      t.string :image
      t.belongs_to :gallery

      t.timestamps
    end
    add_index :g_paintings, :gallery_id
  end
end
