class RemoveUnncessaryTables < ActiveRecord::Migration
  def change
    drop_table :ownerships
    drop_table :elements
    drop_table :parents
    drop_table :ownership_types
    drop_table :oauth_applications
    drop_table :oauth_access_grants
    drop_table :oauth_access_tokens
    drop_table :user_types
    remove_column :users, :user_type_id
  end
end
