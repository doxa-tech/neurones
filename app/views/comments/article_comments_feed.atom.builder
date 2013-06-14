atom_feed do |feed|
	feed.title "- Commentaire de l'article n°: #{@article.id} - #{@article.title}"
	feed.updated @comments.maximum(:updated_at)

	@comments.each do |comment|
		feed.entry(comment, url: root_url + article_path(@article), plublished: comment.created_at) do |entry|
			entry.title comment.title
			entry.content comment.content, type: 'html'
			entry.author do |author|
				author.name 'Lead WAY'
			end
		end
	end
end