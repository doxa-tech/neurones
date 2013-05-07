class CreateGroupGroups < ActiveRecord::Migration
  def change
    create_table :group_groups do |t|
    	t.string :name
      t.string :canton
      t.float :latitude
      t.float :longitude
      t.text :description
      t.string :website
      t.string :street
      t.string :city
      t.integer :npa
      t.belongs_to :canton

      t.timestamps
    end
  end
end
