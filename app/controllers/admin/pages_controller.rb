#!/bin/env ruby
# encoding: utf-8

class Admin::PagesController < Admin::BaseController

	def index
		@pages = Page.page(params[:page]).per_page(10)
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

end
