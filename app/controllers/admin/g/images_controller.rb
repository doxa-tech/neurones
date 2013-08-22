#!/bin/env ruby
# encoding: utf-8

class Admin::G::ImagesController < Admin::G::BaseController

	def index
		@images = current_group.images
	end

	def new
		@image = current_group.images.new
	end

	def create
		@image = current_group.images.new(params[:g_image])
		if @image.save
			flash[:success] = "Image téléversée"
			redirect_to admin_group_g_images_path(current_group)
		else
			render 'new'
		end
	end

	def destroy
		@image = Image.find(params[:id])
		FileUtils.rm_rf("public/uploads/g/image/image/#{@image.id}")
		@image.destroy
		flash[:success] = "Image supprimée"
		redirect_to admin_group_g_images_path(current_group)
	end
end
