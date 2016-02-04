class CommentTable < BaseTable

  def model
    Comment
  end

  def attributes
    [:id, :title, :content, :thumbup, :thumbdown, { user: :name }, { article: :title }, :created_at, :updated_at]
  end

end
