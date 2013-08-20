class CreateGStyles < ActiveRecord::Migration
  def change
    create_table :g_styles do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
