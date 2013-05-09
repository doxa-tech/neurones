class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :content
      t.integer :thumbup, default: 0
      t.integer :thumbdown, default: 0
      t.belongs_to :user
      t.belongs_to :article

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :article_id
  end
end
