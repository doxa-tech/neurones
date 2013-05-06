#!/bin/env ruby
# encoding: utf-8

class SessionsController < ApplicationController

	def plus
	end

	def login
	end

	def create
		params[:session][:name] = params[:session][:name].gsub(/\s+/, "").downcase
		user = User.find_by_name(params[:session][:name])
		if user && user.authenticate(params[:session][:password])
			params[:session][:remember_me] == '1' ? sign_in_permanent(user) : sign_in(user)
			redirect_to admin_profil_path, notice: "Connection réussie."
		else
			flash.now[:error] = "Mot de passe ou nom d'utilisateur incorrect."
			render 'login'
		end
	end

	def destroy 
		sign_out
		redirect_to root_path, notice: "Déconnection réussie."
	end
end
