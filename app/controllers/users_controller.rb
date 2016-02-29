#!/bin/env ruby
# encoding: utf-8

class UsersController < ApplicationController
	before_filter :connected_or_redirect?, only: [:profile, :edit, :update]
	layout 'admin', only: [:profile, :edit, :update]

	def profile
    blacklist = %w[admin/paintings adeia/tokens adeia/groups]
		@elements = current_user.permissions.joins(:element).where('adeia_elements.name NOT IN (?)', blacklist).select('adeia_elements.name')
		@groups = load_records(controller: 'admin/groups')
    @modules = G::Module.joins(:module_type).where(g_module_types: { name: 'group' })
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
      @user.add_to_group('g_base')
			sign_in(@user)
			redirect_to profil_path, success: "Inscription réussie"
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

def connected_or_redirect?
	redirect_to login_path, notice: "Vous devez vous connecter pour accéder à cette page." unless signed_in?
end
