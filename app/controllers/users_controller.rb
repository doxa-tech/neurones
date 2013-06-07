#!/bin/env ruby
# encoding: utf-8

class UsersController < ApplicationController
	before_filter :signed_in?, only: [:show, :edit, :update]

	def show
		#@elements = Element.joins(:ownerships).where('ownerships.user_id = ?', current_user).uniq.select('elements.name, count(ownerships.element_id) info')
		@elements = Ownership.joins(:element).where('user_id = ?', current_user).group('element_id').select('elements.name, count(element_id) info')
		render layout: 'admin';
	end

	def new
		@user = User.new
	end

	def create 
		@user = User.new(params[:user])
		if @user.save
			flash[:success] = "Inscription réussie"
			redirect_to profil_path
		else
			render 'new'
		end
	end

	def edit
		@user = current_user
	end

	def update
		if current_user.authenticate(params[:password][:old_password])
			if current_user.update_attributes(params[:user])
				flash[:success] = "Profil enregistré"
				redirect_to profil_path
			else
				render 'edit'
			end
		else
			flash[:error] = "L'ancien mot de passe ne correspond pas."
			redirect_to profil_path
		end
	end
end
