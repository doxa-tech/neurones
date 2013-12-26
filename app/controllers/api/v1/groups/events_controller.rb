class Api::V1::Groups::EventsController < ApplicationController
	respond_to :json

	def index
		@api_params = {}

		a = @api_params[:per_page] 	= params[:per_page].to_i
		b = @api_params[:page] 			= params[:page].to_i
		c = @api_params[:from] 			= params[:from]
		d = @api_params[:to] 				= params[:to]

		@events = G::Event.where('group_id = ?', params[:group_id]).order('date DESC')
		@events = @events.limit(a).offset((b-1)*a) unless (a==0 || b==0)
		@events = @events.where('date >= ?', c) unless c.nil?
		@events = @events.where('date <= ?', d) unless d.nil?
	end
end
