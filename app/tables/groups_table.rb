class GroupsTable
	include Admin::TablesHelper
	delegate :params, :l, :current_user, :current_group, :render, to: :@view

	def initialize(view, is_group = false)
    @view = view
    @model = Group
    @is_group = is_group
  end

	def attributes(element)
		[
		element.id,
		element.name,
		element.latitude,
		element.longitude,
		element.description,
		element.website,
		element.street,
		element.city,
		element.npa,
		element.canton.name,
		(l element.created_at, format: :short),
		(l element.updated_at, format: :short),
		element.url,
		element.website_activated,
		element.style_id
		]
	end

	def url(element)
		element.url
	end
end