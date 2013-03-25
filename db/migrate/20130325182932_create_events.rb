class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :theme
      t.string :lieu
      t.datetime :date
      t.string :info
      t.string :remarque
      t.integer :image_id
      t.integer :events_type_id

      t.timestamps
    end
  end
end
