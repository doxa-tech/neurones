class AddGravatarEmailToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :gravatar_email, :string
  end
end
