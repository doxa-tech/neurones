#!/bin/env ruby
# encoding: utf-8

class Admin::UsersController < ApplicationController
	before_filter :signed_in_superadmin, only: [:index, :new, :create, :destroy]
	before_filter :correct_user, :signed_in_admin, only: [:edit, :update, :password, :password_update]
	layout 'admin'


	def index
		@users = User.page(params[:page]).per_page(10)
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
		if @user.update_attributes(params[:user])
			flash[:success] = "Profil enregistré"
			sign_in @user
			redirect_to edit_admin_user_path(@user)
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "Utilisateur supprimé"
		redirect_to admin_users_path
	end

	def password
		@user = User.find(params[:id])
	end

	def password_update
		user = User.find(params[:id])
		if user.authenticate(params[:user][:old_password])
			user.password = params[:user][:new_password]
			user.password_confirmation = params[:user][:new_password_confirmation]
			if user.save
				flash[:success] = "Mot de passe enregistré"
				redirect_to edit_admin_user_path(user)
			else
				flash[:error] = "Le nouveau mot de passe n'a pas pu être enregistré. Assurez-vous que la confirmation corresponde et que le mot de passe ait au moins 5 caractères."
				redirect_to password_admin_user_path(user)
			end
		else
			flash[:error] = "L'ancien mot de passe ne correspond pas."
			redirect_to password_admin_user_path(user)
		end
	end

	private

	def correct_user
  	@user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user) || signed_in_superadmin?
  end
end
