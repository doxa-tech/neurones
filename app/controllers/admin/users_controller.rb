#!/bin/env ruby
# encoding: utf-8

class Admin::UsersController < Admin::BaseController
	before_filter :signed_in_superadmin

	def index
		@users = User.page(params[:page]).per_page(10)
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
