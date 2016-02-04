class GEventTable < BaseTable

  def model
    G::Event
  end

	def attributes
		[:id, :title, :content, :date, :created_at, :updated_at]
	end

end
