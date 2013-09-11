class CreateGNews < ActiveRecord::Migration
  def change
    create_table :g_news do |t|
      t.string :title
      t.text :content
      t.date :date_exp
      t.belongs_to :group

      t.timestamps
    end
  end
end
