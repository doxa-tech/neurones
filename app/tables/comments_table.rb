class CommentsTable
	include Admin::TablesHelper
	delegate :params, :l, :current_user, :current_group, :render, to: :@view

	def initialize(view, is_group = false)
    @view = view
    @model = Comment
    @is_group = is_group
  end

	def attributes(element)
		[
		element.id,
		element.title,
		element.content,
		element.thumbup,
		element.thumbdown,
		element.user.name,
		element.article.title,
		(l element.created_at, format: :short),
		(l element.updated_at, format: :short),
		element.comment_id
		]
	end

	def url(element)
		element.id
	end
end