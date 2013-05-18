#!/bin/env ruby
# encoding: utf-8

class UsersController < ApplicationController
	before_filter :signed_in?, only: [:show, :edit, :update]

	def show
	end

	def new
		@user = User.new
	end

	def create 
		@user = User.new(params[:user])
		if @user.save
			flash[:success] = "Utilisateur ajouté"
			redirect_to profile_path
		else
			render 'new'
		end
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user 
		if @current_user.authenticate(params[:password][:old_password])
			if @current_user.update_attributes(params[:user])
				flash[:success] = "Profil enregistré"
				redirect_to profile_path
			else
				render 'edit'
			end
		else
			flash[:error] = "L'ancien mot de passe ne correspond pas."
			redirect_to profile_path
		end
	end
end
