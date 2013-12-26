class Api::V1::Groups::GalleriesController < ApplicationController
	respond_to :json

	def index
		@api_params = {}

		a = @api_params[:per_page] 	= params[:per_page].to_i
		b = @api_params[:page] 			= params[:page].to_i
		c = @api_params[:from] 			= params[:from]
		d = @api_params[:to] 				= params[:to]

		@galleries = G::Gallery.where('group_id = ?', params[:group_id]).order('date DESC')
		@galleries = @galleries.limit(a).offset((b-1)*a) unless (a==0 || b==0)
		@galleries = @galleries.where('date >= ?', c) unless c.nil?
		@galleries = @galleries.where('date <= ?', d) unless d.nil?
	end

end
