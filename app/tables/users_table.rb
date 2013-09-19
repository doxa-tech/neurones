class UsersTable
	include Admin::TablesHelper
	delegate :params, :l, :current_user, :current_group, :render, to: :@view

	def initialize(view, is_group = false)
    @view = view
    @model = User
    @is_group = is_group
  end

	def attributes(element)
		[
		element.id,
		element.name,
		element.password_digest,
		element.remember_token,
		(l element.created_at, format: :short),
		(l element.updated_at, format: :short),
		element.email,
		element.user_type.name,
		element.uid,
		element.gravatar_email
		]
	end

	def url(element)
		element.id
	end
end