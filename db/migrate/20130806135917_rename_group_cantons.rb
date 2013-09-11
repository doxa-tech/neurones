class RenameGroupCantons < ActiveRecord::Migration
  def change
    rename_table :group_cantons, :cantons
  end
end
