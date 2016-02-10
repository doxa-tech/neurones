#!/bin/env ruby
# encoding: utf-8

class Admin::SlideshowsController < Admin::BaseController
  load_and_authorize

	def index
		@table = Table.new(self, Slideshow, @slideshows)
	  @table.respond
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
	end

	def update
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
		FileUtils.rm_rf("public/slideshow/image/#{@slideshow.id}")
		@slideshow.destroy
		flash[:success] = "Slideshow supprimé"
		redirect_to admin_slideshows_path
	end
end
