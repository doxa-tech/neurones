#!/bin/env ruby
# encoding: utf-8

class Admin::ImagesController < Admin::BaseController
	before_filter only: [:destroy] {|controller| controller.modify_right(Image)}
	before_filter only: [:index] do |controller|
		controller.index_ownerships
		controller.index_right(Image)
	end

	def index
		# see before_filter
	end

	def new
		@image = Image.new
	end

	def create
		@image = Image.new(params[:image])
		if @image.save
			flash[:success] = "Image téléversée"
			redirect_to admin_images_path
		else
			render 'new'
		end
	end

	def destroy
		@image = Image.find(params[:id])
		@image.remove_image!
		@image.destroy
		flash[:success] = "Image supprimée"
		redirect_to admin_images_path
	end

end
