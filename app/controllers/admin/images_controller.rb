#!/bin/env ruby
# encoding: utf-8

class Admin::ImagesController < Admin::BaseController
	load_and_authorize

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
		@image.remove_image!
		@image.destroy
		flash[:success] = "Image supprimée"
		redirect_to admin_images_path
	end

end
