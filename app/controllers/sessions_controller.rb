#!/bin/env ruby
# encoding: utf-8

class SessionsController < ApplicationController
	before_filter :is_connected?, only: [:login, :create]

	# used in the dynamic login form

	def login
		@user = User.new
	end

	def create
		params[:session][:email] = params[:session][:email].gsub(/\s+/, "").downcase
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			params[:session][:remember_me] == '1' ? sign_in_permanent(user) : sign_in(user)
			respond_to do |format|
      	format.html { redirect_back_or(root_path); flash[:success] = "Vous êtes connecté." }
      	format.js { render 'create_success' }
    	end
		else
			flash.now[:error] = "Nom d'utilisateur ou/et mot de passe incorrect."
			respond_to do |format|
      	format.html { render 'login' }
      	format.js { render 'create_error' }
    	end
		end
	end

	def destroy
		sign_out
		redirect_to root_path, notice: "Vous êtes déconnecté."
	end

	private

	def is_connected?
		redirect_to profil_path if signed_in?
	end
end
