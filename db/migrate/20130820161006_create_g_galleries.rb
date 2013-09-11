class CreateGGalleries < ActiveRecord::Migration
  def change
    create_table :g_galleries do |t|
      t.string :name
      t.text :description
      t.date :date
      t.belongs_to :group

      t.timestamps
    end
    add_index :g_galleries, :group_id
  end
end
