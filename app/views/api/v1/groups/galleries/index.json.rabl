if @galleries
	node :data do
		{total: @galleries.size, provider: 'http://store.cloud.google.com', api_params: @api_params, galleries: partial("api/v1/groups/galleries/body", :object => @galleries)}
	end
end