#!/bin/env ruby
# encoding: utf-8

class Admin::PagesController < Admin::BaseController
	before_filter only: [:index] {|controller| controller.index_right(Page)}
	before_filter only: [:destroy, :edit, :update, :mercury_update] {|controller| controller.modify_right(Page)}

	def index
		#see before_filter
	end

	def edit
		@page = Page.find(params[:id])
	end

	def update
		@page = Page.find(params[:id])
		if @page.update_attributes(params[:page])
			flash[:success] = 'Page enregistrée'
			redirect_to admin_pages_path 
		else
			render 'edit'
		end
	end

	def mercury_update
  	page = Page.find(params[:id])
  	page.title = params[:content][:page_title][:value]
  	page.content = params[:content][:page_content][:value]
  	page.save!
 	 	render text: '{"url":"/blog"}'
	end

end
