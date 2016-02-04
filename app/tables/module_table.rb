class ModuleTable < BaseTable

  def model
    G::Module
  end

	def attributes
    [:id, :name, :description]
	end

end
