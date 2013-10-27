#!/bin/env ruby
# encoding: utf-8

class SessionsController < ApplicationController
	before_filter :is_connected?, only: [:login, :create]

	def plus
	end

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

	# -- callback from omniauth
	# First need to check if there is a name for github
	# Then check if user is already in the DB or create new one
	def check_external
		#raise env['omniauth.auth'].to_yaml
		if env['omniauth.auth']['info']['name'].nil?
			redirect_to root_path, notice: 'veuillez compléter votre profil github avec votre nom.'
		else
			if (user = User.from_omniauth(env['omniauth.auth'])).nil?
				# create user
				user = User.create_from_omniauth(env['omniauth.auth'])
				# add to groups
				Parent.create(user_id: user.id, parent_id: User.find_by_name('g_base').id)
				Parent.create(user_id: user.id, parent_id: User.find_by_name('g_ext').id)
				sign_in(user)
				flash[:success] = "Un nouveau compte à été créé. Vous avez dorénavant un profil sur neurones.ch. A chaque fois que vous vous connecterez à neurones avec la même méthode d'authentification vous aurez accès à votre profil."
				redirect_back_or(root_path)
			else
				sign_in(user)
				flash[:success] = "Vous êtes connecté."
				redirect_back_or(root_path)
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
