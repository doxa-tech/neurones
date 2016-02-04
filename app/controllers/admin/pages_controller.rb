#!/bin/env ruby
# encoding: utf-8

class Admin::PagesController < Admin::BaseController
	before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(Page)}

	def index
		@table = Table.new(self, Page)
	  @table.respond
	end

	def edit
		@page = Page.find(params[:id])
	end

	def update
		@page = Page.find(params[:id])
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
