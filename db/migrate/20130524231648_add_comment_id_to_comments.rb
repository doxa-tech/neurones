class AddCommentIdToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :comment_id, :integer
  	add_index :comments, :comment_id
  end
end
