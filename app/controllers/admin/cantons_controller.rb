#!/bin/env ruby
# encoding: utf-8

class Admin::CantonsController < Admin::BaseController
  before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(Canton)}

	def index
		respond_to do |format|
    	format.html
    	format.json { render json: Datatable.new(view_context, Canton) }
  	end
	end

	def new 
		@canton = Canton.new
	end

	def create 
		@canton = Canton.new(params[:group_canton])
		if @canton.save
			flash[:success] = "Canton ajouté"
			redirect_to admin_cantons_path
		else
			render 'new'
		end
	end

	def edit
		@canton = Canton.find(params[:id])
	end

	def update
		@canton = Canton.find(params[:id])
		if @canton.update_attributes(params[:group_canton])
			flash[:success] = "Canton enregistré"
			redirect_to admin_cantons_path
		else
			render 'edit'
		end
	end

	def destroy
		Canton.find(params[:id]).destroy
		flash[:success] = "Canton supprimé"
		redirect_to admin_cantons_path
	end
end
