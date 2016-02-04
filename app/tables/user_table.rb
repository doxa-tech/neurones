class UserTable < BaseTable

  def model
    User
  end

	def attributes
		[:id, :name, :email, :gravatar_email, { user_type: :name }, :created_at, :updated_at]
	end

end
