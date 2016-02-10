class GroupTable < BaseTable

  def model
    Group
  end

  def attributes
    [:id, :name, :latitude, :longitude, :description, :website, :street, :city, :npa, { canton: :name }, :url, :website_activated, :created_at, :updated_at]
  end

  def url
    :url
  end

end
