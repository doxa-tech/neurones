#!/bin/env ruby
# encoding: utf-8

class Admin::OwnershipsController < Admin::BaseController
	before_filter only: [:index] {|controller| controller.index_right(Ownership)}
	before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(Ownership)}

	def index
		#see before_filter
	end

	def new
		@ownership = Ownership.new
	end

	def create
		@ownership = Ownership.new(params[:ownership])
		if @ownership.save
			flash[:success] = "Possession ajoutée"
			redirect_to admin_ownerships_path
		else
			render 'new'
		end
	end

	def edit
		@ownership = Ownership.find(params[:id])
	end

	def create
		@ownership = Ownership.find(params[:id])
		if @ownership.update_attributes(params[:ownership])
			flash[:success] = "Possession enregistrée"
			redirect_to admin_ownerships_path
		else
			render 'edit'
		end
	end

	def destroy
		Ownership.find(params[:id]).destroy
		flash[:success] = "Possession supprimée"
		redirect_to admin_ownerships_path
	end
end
