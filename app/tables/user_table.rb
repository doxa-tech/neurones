class UserTable < BaseTable

  def model
    User
  end

	def attributes
		[:id, :name, :email, :gravatar_email, :created_at, :updated_at]
	end

end
