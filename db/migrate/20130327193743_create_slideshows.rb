class CreateSlideshows < ActiveRecord::Migration
  def change
    create_table :slideshows do |t|
      t.string :name
      t.string :image
      t.string :link

      t.timestamps
    end
  end
end
