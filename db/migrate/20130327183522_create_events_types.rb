class CreateEventsTypes < ActiveRecord::Migration
  def change
    create_table :events_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
