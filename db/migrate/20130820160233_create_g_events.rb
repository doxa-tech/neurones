class CreateGEvents < ActiveRecord::Migration
  def change
    create_table :g_events do |t|
      t.string :title
      t.text :content
      t.datetime :date
      t.belongs_to :group      

      t.timestamps
    end
  end
end
