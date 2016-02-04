class GGalleryTable < BaseTable

  def model
    G::Gallery
  end

	def attributes
		[:id, :name, :description, :date, :created_at, :updated_at]
	end

end
