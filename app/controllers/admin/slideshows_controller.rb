#!/bin/env ruby
# encoding: utf-8

class Admin::SlideshowsController < Admin::BaseController

	def index
		@slideshows = Slideshow.page(params[:page]).per_page(10)
	end

	def new
		@slideshow = Slideshow.new
	end

	def create
		@slideshow = Slideshow.new(params[:slideshow])
		if @slideshow.save
			flash[:success] = "Slideshow créé"
			redirect_to admin_slideshows_path
		else
			render 'new'
		end
	end

	def edit
		@slideshow = Slideshow.find(params[:id])
	end

	def update
		@slideshow = Slideshow.find(params[:id])
		if @slideshow.image != nil && params[:image] != nil
			FileUtils.rm_rf("public/slideshow/image/#{@slideshow.id}")
		end
		if @slideshow.update_attributes(params[:slideshow])
			flash[:success] = "Slideshow édité"
			redirect_to admin_slideshows_path
		else
			render 'edit'
		end
	end

	def destroy
		@slideshow = Slideshow.find(params[:id])
		FileUtils.rm_rf("public/slideshow/image/#{@slideshow.id}")
		@slideshow.destroy
		flash[:success] = "Slideshow supprimé"
		redirect_to admin_slideshows_path
	end
end