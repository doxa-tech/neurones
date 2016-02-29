#!/bin/env ruby
# encoding: utf-8

class Admin::UsersController < Admin::BaseController
	load_and_authorize

	def index
		@table = UserTable.new(self, @users)
	  @table.respond
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
	end

	def update
		if @user.update_attributes(params[:user])
			flash[:success] = "Utilisateur enregistré"
			redirect_to admin_users_path
		else
			render 'edit'
		end
	end

	def destroy
		@user.destroy
		flash[:success] = "Utilisateur supprimé"
		redirect_to admin_users_path
	end
end
