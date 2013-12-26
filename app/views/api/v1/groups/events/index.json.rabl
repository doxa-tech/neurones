if @events
	node :data do
		{total: @events.size, api_params: @api_params, events: partial("api/v1/groups/events/body", :object => @events)}
	end
end