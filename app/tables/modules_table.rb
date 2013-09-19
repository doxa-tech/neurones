class ModulesTable
	include Admin::TablesHelper
	delegate :params, :l, :current_user, :current_group, :render, to: :@view

	def initialize(view, is_group = false)
    @view = view
    @model = G::Module
    @is_group = is_group
  end

	def attributes(element)
		[
		element.id,
		element.name,
		(l element.created_at, format: :short),
		(l element.updated_at, format: :short),
		element.module_type.try(:name),
		element.module.try(:name),
		element.description,
		element.image
		]
	end

	def url(element)
		element.id
	end
end