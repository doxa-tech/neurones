#!/bin/env ruby
# encoding: utf-8

class Admin::OwnershipsController < Admin::BaseController
	# special ownerships
	before_filter :ownerships_right, only: [:index]
	before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(Ownership)}

	def index
		@ownership_table = OwnershipTable.new(self)
		@parent_table = ParentTable.new(self)
		@user_table = UserTable.new(self)
    @group_table = UserGroupTable.new(self, User.joins(:user_type).where(user_types: { name: "group" }))
		@user_type_table = Table.new(self, UserType)
		@element_table = Table.new(self, Element)
	end

	def new
		@ownership = Ownership.new
		@ownership.user_id = params[:user_id]
	end

	def create
		@ownership = Ownership.new(params[:ownership])
		if @ownership.save
			flash[:success] = "Droit ajouté"
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
			flash[:success] = "Droit enregistré"
			redirect_to admin_ownerships_path
		else
			render 'edit'
		end
	end

	def destroy
		Ownership.find(params[:id]).destroy
		flash[:success] = "Droit supprimé"
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
