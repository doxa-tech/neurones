class CommentsDatatable
	include Admin::RightsHelper
  include Admin::DatatablesHelper
  delegate :params, :current_user, :l, :truncate, to: :@view
  

  def initialize(view)
    @view = view
    @model = Comment
  end

private

  def data
    elements.map do |element|
      [
        element.id,
        element.title,
        truncate(element.content.to_s),
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

  def search_request
    @user_ids = User.where('name like ?', "%#{params[:sSearch]}%" ).pluck(:id)
    @article_ids = Article.where('title like ?', "%#{params[:sSearch]}%" ).pluck(:id)
    @elements = @elements.where(search_columns + ' or user_id IN (:user_ids) or article_id IN (:article_ids)' , text: "%#{params[:sSearch]}%", number: @number, date: @date, date_after: (@date + 1 unless @date.nil?), user_ids: @user_ids, article_ids: @article_ids)
  end
end