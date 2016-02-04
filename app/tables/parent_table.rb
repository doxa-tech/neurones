class ParentTable < BaseTable

  def model
    Parent
  end

	def attributes
		[:id, { user: :name }, { parent: :name }, :created_at, :updated_at]
	end

end
