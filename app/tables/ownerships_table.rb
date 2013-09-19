class OwnershipsTable
	include Admin::TablesHelper
	delegate :params, :l, :current_user, :current_group, :render, to: :@view

	def initialize(view, is_group = false)
    @view = view
    @model = Ownership
    @is_group = is_group
  end

	def attributes(element)
		[
		element.id,
		element.element.name,
		element.user.name,
		element.ownership_type.name,
		(l element.created_at, format: :short),
		(l element.updated_at, format: :short),
		element.right_read,
		element.right_create,
		element.right_update,
		element.right_delete,
		element.id_element
		]
	end

	def url(element)
		element.id
	end
end