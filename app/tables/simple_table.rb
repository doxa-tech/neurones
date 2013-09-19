class SimpleTable
	delegate :render, to: :@view

	def initialize(view, columns, elements)
		@view = view
    @elements = elements
    @columns = columns
  end

	def build
		render 'tables/simple_table', columns: @columns, elements: @elements
	end
end