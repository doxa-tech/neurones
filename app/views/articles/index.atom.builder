atom_feed do |feed|
	feed.title "- Articles de #{@articles.first.user.name}"
	feed.updated @articles.maximum(:updated_at)

	@articles.each do |article|
		feed.entry(article, url: blog_path, plublished: article.created_at) do |entry|
			entry.title article.title
			entry.content article.content, type: 'html'
			entry.author do |author|
				author.name 'Lead WAY'
			end
		end
	end
end