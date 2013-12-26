class Api::V1::Groups::NewsController < ApplicationController
	respond_to :json

	def index
		@api_params = {}

		a = @api_params[:per_page] 	= params[:per_page].to_i
		b = @api_params[:page] 			= params[:page].to_i
		c = @api_params[:from] 			= params[:from]
		d = @api_params[:to] 				= params[:to]
		e = @api_params[:only_fresh]= params[:only_fresh]

		@news = G::New.where('group_id = ?', params[:group_id]).order('date_exp DESC')
		@news = @news.limit(a).offset((b-1)*a) unless (a==0 || b==0)
		@news = @news.where('created_at >= ?', c) unless c.nil?
		@news = @news.where('created_at <= ?', d) unless d.nil?
		@news = @news.where('date_exp >= ?', Time.zone.now) unless e.nil?
	end
end
