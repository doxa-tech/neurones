#!/bin/env ruby
# encoding: utf-8

class Admin::OwnershipsController < Admin::BaseController
	before_filter :ownerships_right, only: [:index]
	before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(Ownership)}

	def index
		@groups = User.where('user_type_id = ?', UserType.find_by_name('group').id )
		@user_types = UserType.all
		@access_types = ['create', 'update', 'delete', 'read']
		@elements = Element.all
	end

	def ownerships
		respond_to do |format|
    	format.html
    	format.json { render json: OwnershipsDatatable.new(view_context) }
  	end
	end

	def parents
		respond_to do |format|
    	format.html
    	format.json { render json: Datatable.new(view_context, Parent) }
  	end
	end

	def new
		@ownership = Ownership.new
	end

	def create
		@ownership = Ownership.new(params[:ownership])
		if @ownership.save
			flash[:success] = "Possession ajoutée"
			redirect_to admin_ownerships_path
		else
			render 'new'
		end
	end

	def edit
		@ownership = Ownership.find(params[:id])
	end

	def update
		@ownership = Ownership.find(params[:id])
		if @ownership.update_attributes(params[:ownership])
			flash[:success] = "Possession enregistrée"
			redirect_to admin_ownerships_path
		else
			render 'edit'
		end
	end

	def destroy
		Ownership.find(params[:id]).destroy
		flash[:success] = "Possession supprimée"
		redirect_to admin_ownerships_path
	end
end

private

def ownerships_right
	element_ownerships_id = Element.find_by_name('admin/ownerships').id
	element_parents_id = Element.find_by_name('admin/parents').id
	id_parents = Parent.where('user_id = ?', current_user).pluck('parent_id')
	id_parents.push(current_user.id)
	ownerships = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_read = ?', id_parents, element_ownerships_id, OwnershipType.find_by_name('all_entries').id, true )
	@create_parent_ownerships = Ownership.where('user_id IN (?) AND element_id = ? AND right_create = ?', id_parents, element_parents_id, true )
	redirect_to root_path, notice: "Vous n'avez pas les droits nécessaires pour accéder à cette page." unless ownerships.any?	
end