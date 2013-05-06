class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :canton
      t.float :latitude
      t.float :longitude
      t.text :description
      t.string :website
      t.string :street
      t.string :city
      t.integer :npa

      t.timestamps
    end
  end
end
