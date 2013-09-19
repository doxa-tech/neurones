class GNewsTable
	include Admin::TablesHelper
	delegate :params, :l, :current_user, :current_group, :render, to: :@view

	def initialize(view, is_group = false)
    @view = view
    @model = G::New
    @is_group = is_group
  end

	def attributes(element)
		[
		element.id,
		element.title,
		element.content,
		element.date_exp,
		element.group.name,
		(l element.created_at, format: :short),
		(l element.updated_at, format: :short)
		]
	end

	def url(element)
		element.id
	end
end