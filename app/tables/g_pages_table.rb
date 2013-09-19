class GPagesTable
	include Admin::TablesHelper
	delegate :params, :l, :current_user, :current_group, :render, to: :@view

	def initialize(view, is_group = false)
    @view = view
    @model = G::Page
    @is_group = is_group
  end

	def attributes(element)
		[
		element.id,
		element.content,
		element.url,
		element.page_order,
		element.name,
		element.group.name,
		(l element.created_at, format: :short),
		(l element.updated_at, format: :short)
		]
	end

	def url(element)
		element.id
	end
end