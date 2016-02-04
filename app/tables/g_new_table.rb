class GNewTable < BaseTable

  def model
    G::New
  end

	def attributes
		[:id, :title, :content, :date_exp, :created_at, :updated_at]
	end

end
