if @news
	node :data do
		{total: @news.size, api_params: @api_params, galleries: partial("api/v1/groups/news/body", :object => @news)}
	end
end