class CreateGTexts < ActiveRecord::Migration
  def change
    create_table :g_texts do |t|
      t.text :content
      t.integer :text_order
      t.belongs_to :page
      t.belongs_to :comp_page

      t.timestamps
    end
    add_index :g_texts, :page_id

    remove_column :g_comp_pages, :content
  end
end
