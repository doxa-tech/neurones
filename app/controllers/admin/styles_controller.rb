#!/bin/env ruby
# encoding: utf-8

class Admin::StylesController < Admin::BaseController
	before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(G::Style)}

	def index
		@table = Table.new(self, G::Style)
	  @table.respond
	end

	def new
		@style = G::Style.new
	end

	def create
		@style = G::Style.new(params[:g_style])
		@style.theme = true
		if @style.save
			flash[:success] = "Style ajouté"
			redirect_to admin_g_styles_path
		else
			render 'new'
		end
	end

	def edit
		@style = G::Style.find(params[:id])
	end

	def update
		@style = G::Style.find(params[:id])
		if @style.update_attributes(params[:g_style])
			flash[:success] = "Style enregistré"
			redirect_to admin_g_styles_path
		else
			render 'edit'
		end
	end

	def destroy
		G::Style.find(params[:id]).destroy
		flash[:success] = "Style supprimé"
		redirect_to admin_g_styles_path
	end
end
