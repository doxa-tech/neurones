atom_feed do |feed|
	feed.title "- Réaction du commentaire n° #{@comment.id} - #{@comment.title} de l'article n° #{@article.id} - #{@article.title}"
	feed.updated @subcomments.maximum(:updated_at)

	@subcomments.each do |subcomments|
		feed.entry(subcomments, url: root_url + article_path(@article), plublished: subcomments.created_at) do |entry|
			entry.title subcomments.title
			entry.content subcomments.content, type: 'html'
			entry.author do |author|
				author.name 'Lead WAY'
			end
		end
	end
end