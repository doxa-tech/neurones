#!/bin/env ruby
# encoding: utf-8

class Admin::OwnershipsController < Admin::BaseController
	before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(Ownership)}

	def index
		#@groups = User.where('user_type_id = ?', UserType.find_by_name('group').id).page(params[:page]).per_page(10)
		#@user_types = UserType.page(params[:page]).per_page(10)
		respond_to do |format|
    	format.html
    	format.json { render json: Datatable.new(view_context, Ownership) }
  	end
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
