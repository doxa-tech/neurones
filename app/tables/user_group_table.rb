class UserGroupTable < BaseTable

  def model
    User
  end

  def attributes
    [:name]
  end

end
