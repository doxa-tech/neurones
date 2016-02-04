class ArticleTable < BaseTable

  def model
    Article
  end

  def attributes
    [:title, :subtitle, :content, :likes, { category: :name }, { user: :name }, :created_at, :updated_at]
  end

end
