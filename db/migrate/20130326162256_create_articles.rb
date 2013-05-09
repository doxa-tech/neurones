class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :subtitle
  		t.integer :likes, default: 0
  		t.belongs_to :user
  		t.belongs_to :category

      t.timestamps
    end
  end
end
