class AddDateExpToSlideshows < ActiveRecord::Migration
  def change
  	add_column :slideshows, :date_exp, :date
  end
end
