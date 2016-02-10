#!/bin/env ruby
# encoding: utf-8

class Admin::PagesController < Admin::BaseController
	load_and_authorize

	def index
		@table = Table.new(self, Page, @pages)
	  @table.respond
	end

	def edit
	end

	def update
		if @page.update_attributes(params[:page])
			flash[:success] = 'Page enregistrée'
			respond_to do |format|
				format.html { redirect_to admin_pages_path }
				format.js { render 'success' }
			end
		else
			respond_to do |format|
				format.html { render 'edit' }
				format.js { render 'error' }
			end
		end
	end
end
