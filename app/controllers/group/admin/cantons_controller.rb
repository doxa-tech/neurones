#!/bin/env ruby
# encoding: utf-8

class Group::Admin::CantonsController < Admin::BaseController
	before_filter only: [:index] {|controller| controller.index_right(Group::Canton)}
	before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(Group::Canton)}

	def index
	 #see before_filter
	end

	def new 
		@canton = Group::Canton.new
	end

	def create 
		@canton = Group::Canton.new(params[:group_canton])
		if @canton.save
			flash[:success] = "Canton ajoutée"
			redirect_to admin_group_cantons_path
		else
			render 'new'
		end
	end

	def edit
		@canton = Group::Canton.find(params[:id])
	end

	def update
		@canton = Group::Canton.find(params[:id])
		if @canton.update_attributes(params[:group_canton])
			flash[:success] = "Canton enregistrée"
			redirect_to admin_group_cantons_path
		else
			render 'edit'
		end
	end

	def destroy
		Group::Canton.find(params[:id]).destroy
		flash[:success] = "Canton supprimée"
		redirect_to admin_group_cantons_path
	end

end
