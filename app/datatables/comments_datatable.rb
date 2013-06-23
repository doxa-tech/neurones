class CommentsDatatable
	include Admin::RightsHelper
  include Admin::DatatablesHelper
  delegate :params, :current_user, :l, :truncate, to: :@view
  

  def initialize(view, model)
    @view = view
    @model = model
    index_ownerships
  end

private

  def data
    elements.map do |element|
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
  end
end