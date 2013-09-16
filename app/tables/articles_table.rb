class ArticlesTable
	include Admin::TablesHelper
	delegate :params, :raw, :sanitize, :current_user, :current_group, :render, to: :@view

	def initialize(view, is_group = false)
    @view = view
    @model = Article
    @is_group = is_group
  end

	def attributes(element)
		[
		element.id,
		element.title,
		element.content,
		element.subtitle,
		element.likes,
		element.user.name,
		element.category.name,
		element.created_at,
		element.updated_at,
		element.image
		]
	end

	def url(element)
		element.id
	end
end