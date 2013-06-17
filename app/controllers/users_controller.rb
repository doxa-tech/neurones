#!/bin/env ruby
# encoding: utf-8

class UsersController < ApplicationController
	before_filter :signed_in?, only: [:show, :edit, :update]

	def profile
		# Get parents
		id_parents = Parent.where('user_id = ?', current_user).pluck('parent_id')
		id_parents.push(current_user.id)
		@elements = Ownership.joins(:element).where('user_id IN (?)', id_parents).group('element_id').select('elements.name, count(element_id) info')
		render layout: 'admin'
	end

	def show 
	end

	def new
		@user = User.new
	end

	def create 
		params[:user][:user_type_id] = UserType.find_by_name('user').id
		@user = User.new(params[:user])
		if @user.save
			# add to groups
			Parent.create(user_id: @user.id, parent_id: User.find_by_name('g_base').id)
			Parent.create(user_id: @user.id, parent_id: User.find_by_name('g_user').id)
			flash[:success] = "Inscription réussie"
			sign_in(@user)
			redirect_to profil_path
		else
			render 'new'
		end
	end

	def edit
		@user = current_user
		render layout: 'admin'
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
