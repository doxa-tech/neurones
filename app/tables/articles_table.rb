class ArticlesTable
	include Admin::TablesHelper
	delegate :params, :render, to: :@view

	def initialize(view)
    @view = view
    @model = Article
  end

	def data
		elements.map do |element|	
			url(element.id) +
			f(element.id) +
			f(element.title) +
			f(element.content) +
			f(element.user.name) +
			f(element.created_at) +
			f(element.updated_at)
		end
	end
end