#!/bin/env ruby
# encoding: utf-8

class SessionsController < ApplicationController

	def new
	end

	def create
		params[:session][:name] = params[:session][:name].gsub(/\s+/, "").downcase
		user = User.find_by_name(params[:session][:name])
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to edit_admin_user_path(user), notice: "Connection réussie."
		else
			flash.now[:error] = "Mot de passe ou nom d'utilisateur incorrect."
			render 'new'
		end
	end

	def destroy 
		sign_out
		redirect_to root_path, notice: "Déconnection réussie."
	end
end
