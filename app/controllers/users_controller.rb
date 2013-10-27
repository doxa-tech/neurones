#!/bin/env ruby
# encoding: utf-8

class UsersController < ApplicationController
	before_filter :signed_in_or_redirect?, only: [:profile, :edit, :update]
	before_filter :group_ownerships, only: [:profile]
	layout 'admin', only: [:profile, :show, :edit, :update]

	def profile
		# Get parents
		id_parents = Parent.where('user_id = ?', current_user).pluck('parent_id')
		id_parents.push(current_user.id)
		# need different name rather than @elements
		@my_elements = Ownership.joins(:element).where('user_id IN (?)', id_parents).group('elements.name').select('elements.name, count(element_id) info')
		@groups = index_right(Group)
	end

	def show
		@user = User.find(params[:id]) 
	end

	def new
		@user = User.new
	end

	def create 
		@user = User.new(params[:user])
		@user.user_type_id = UserType.find_by_name('user').id
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
	end

	def update
		@user = current_user
		# check if the old password is right
		authentication = @user.authenticate(params[:password][:old_password])
		@user.assign_attributes(params[:user])
		if @user.valid? && authentication
			@user.save
			sign_in(@user)
			flash[:success] = "Profil enregistré"
			redirect_to profil_path
		else
			@user.errors.add(:old_password, "n'est pas correct.") if authentication == false
			render 'edit'
		end
	end
end

private

def signed_in_or_redirect?
	redirect_to login_path, notice: "Vous devez vous connecter pour accéder à cette page."  unless !current_user.nil?
end

