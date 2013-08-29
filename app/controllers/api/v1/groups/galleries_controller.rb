class Api::V1::Groups::GalleriesController < ApplicationController
	respond_to :json

	def index
		@galleries = G::Gallery.where('group_id = ?', params[:group_id])
	end

end
