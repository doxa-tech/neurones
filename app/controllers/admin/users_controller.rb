#!/bin/env ruby
# encoding: utf-8

class Admin::UsersController < Admin::BaseController
	before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(User)}

	def index
		respond_to do |format|
    	format.html
    	format.json { render json: Datatable.new(view_context, User) }
  	end
	end

	def new
		@user = User.new
		@user.parents.build
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:success] = "Utilisateur ajouté"
			redirect_to admin_users_path
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update 
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Utilisateur enregistré"
			redirect_to admin_users_path
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "Utilisateur supprimé"
		redirect_to admin_users_path
	end

end
