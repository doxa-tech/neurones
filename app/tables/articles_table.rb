class ArticlesTable
	include Admin::TablesHelper
	delegate :params, :raw, :current_user, :current_group, :render, to: :@view

	def initialize(view, is_group = false)
    @view = view
    @model = Article
    @is_group = is_group
  end
  
	def display_attributes(element)
		raw(
		url(element.id) +
		f(element.id) +
		f(element.title) +
		f(element.content) +
		f(element.subtitle) +
		f(element.likes) +
		f(element.user.name) +
		f(element.category.name) +
		f(element.created_at) +
		f(element.updated_at) +
		f(element.image)
		)
	end
end