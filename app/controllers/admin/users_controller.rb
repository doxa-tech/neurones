#!/bin/env ruby
# encoding: utf-8

class Admin::UsersController < ApplicationController
	before_filter :signed_in_superadmin, only: [:index, :new, :create, :destroy, :edit]
	before_filter :correct_user, :signed_in_admin, only: [:update, :destroy]
	layout 'admin'

	def index
		@users = User.page(params[:page]).per_page(10)
	end

	def profile
	end

	def new
		@user = User.new
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
		if @user.authenticate(params[:password][:old_password]) || current_user != @user
			if @user.update_attributes(params[:user])
				flash[:success] = "Profil enregistré"
				sign_in @user if current_user == @user 
				session[:return_to] == '/admin/profil' ? redirect_to(admin_profil_path) : redirect_to(admin_users_path)
			else
				render 'edit'
			end
		else
			flash[:error] = "L'ancien mot de passe ne correspond pas."
			session[:return_to] == '/admin/profil' ? redirect_to(admin_profil_path) : redirect_to(admin_users_path)
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "Utilisateur supprimé"
		redirect_to admin_users_path
	end

	private

	def correct_user
  	@user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user) || signed_in_superadmin?
  end
end
