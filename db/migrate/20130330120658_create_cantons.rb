class CreateCantons < ActiveRecord::Migration
  def change
    create_table :cantons do |t|
      t.string :name

      t.timestamps
    end
  end
end
