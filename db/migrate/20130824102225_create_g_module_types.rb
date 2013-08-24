class CreateGModuleTypes < ActiveRecord::Migration
  def change
    create_table :g_module_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
