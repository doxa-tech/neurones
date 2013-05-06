class CreatePaintings < ActiveRecord::Migration
  def change
    create_table :paintings do |t|
      t.string :name
      t.string :image
      t.integer :gallery_id

      t.timestamps
    end
  end
end
