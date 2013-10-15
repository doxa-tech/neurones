#!/bin/env ruby
# encoding: utf-8

module Admin::RightsHelper
	require 'will_paginate/array'
	# called by controllers on CRUD actions. Perform a redirect_to if unnecessary right

	# basic_controller method

	def connected?
		if !current_user.nil?
			element_id = Element.find_by_name(params[:controller]).id
			@id_parents = Parent.where('user_id = ?', current_user).pluck('parent_id')
			@id_parents.push(current_user.id)
			case params[:action]
			when 'index'
				@create_ownerships = Ownership.where('user_id IN (?) AND element_id = ? AND right_create = ?', @id_parents, element_id, true)
				@update_ownerships = Ownership.where('user_id IN (?) AND element_id = ? AND right_update = ?', @id_parents, element_id, true)
				@delete_ownerships = Ownership.where('user_id IN (?) AND element_id = ? AND right_delete = ?', @id_parents, element_id, true)
			when 'new' 
				@ownerships_all = Ownership.where('user_id IN (?) AND element_id = ? AND right_create = ?', @id_parents, element_id, true )
				redirect_to root_path, notice: "Vous n'avez pas les droits nécessaires." unless @ownerships_all.any?
			when 'create'
				@ownerships_all = Ownership.where('user_id IN (?) AND element_id = ? AND right_create = ?', @id_parents, element_id, true )
				redirect_to root_path, notice: "Vous n'avez pas les droits nécessaires." unless @ownerships_all.any?
			when 'edit'
				@ownerships_all = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_update = ?', @id_parents, element_id, OwnershipType.find_by_name('all_entries').id, true )
				@ownerships_on_ownership = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_update = ?', @id_parents, element_id, OwnershipType.find_by_name('on_ownership').id, true)
				@ownerships_on_entry = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_update = ?', @id_parents, element_id, OwnershipType.find_by_name('on_entry').id, true).pluck('id_element')
			when 'update'
				@ownerships_all = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_update = ?', @id_parents, element_id, OwnershipType.find_by_name('all_entries').id, true )
				@ownerships_on_ownership = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_update = ?', @id_parents, element_id, OwnershipType.find_by_name('on_ownership').id, true)
				@ownerships_on_entry = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_update = ?', @id_parents, element_id, OwnershipType.find_by_name('on_entry').id, true).pluck('id_element')
			when 'destroy'
				@ownerships_all = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_delete = ?', @id_parents, element_id, OwnershipType.find_by_name('all_entries').id, true )
				@ownerships_on_ownership = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_delete = ?', @id_parents, element_id, OwnershipType.find_by_name('on_ownership').id, true )
				@ownerships_on_entry = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_delete = ?', @id_parents, element_id, OwnershipType.find_by_name('on_entry').id, true ).pluck('id_element')
			end
		else
			store_location
			respond_to do |format|
				format.html { redirect_to(login_path, notice: "Connectez-vous pour accéder à cette page.") }
				format.js { render 'shared/unconnected'}
			end 
		end
	end

	###
	#Fetch db for ownerships
	###

	def index_ownerships(name = params[:controller])
		element_id = Element.find_by_name(name).id
		@id_parents = Parent.where('user_id = ?', current_user).pluck('parent_id')
		@id_parents.push(current_user.id)
		@ownerships_all = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_read = ?', @id_parents, element_id, OwnershipType.find_by_name('all_entries').id, true )
		@ownerships_on_ownership = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_read = ?', @id_parents, element_id, OwnershipType.find_by_name('on_ownership').id, true )
		@ownerships_on_entry = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_read = ?', @id_parents, element_id, OwnershipType.find_by_name('on_entry').id, true ).pluck('id_element')
	end

	def update_ownerships
		element_id = Element.find_by_name(params[:controller]).id
		@id_parents = Parent.where('user_id = ?', current_user).pluck('parent_id')
		@id_parents.push(current_user.id)
		@ownerships_all = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_update = ?', @id_parents, element_id, OwnershipType.find_by_name('all_entries').id, true )
		@ownerships_on_ownership = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_update = ?', @id_parents, element_id, OwnershipType.find_by_name('on_ownership').id, true)
		@ownerships_on_entry = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_update = ?', @id_parents, element_id, OwnershipType.find_by_name('on_entry').id, true).pluck('id_element')
	end

	def group_ownerships
		element_id = Element.find_by_name('admin/groups').id
		@id_parents = Parent.where('user_id = ?', current_user).pluck('parent_id')
		@id_parents.push(current_user.id)
		@ownerships_all = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_update = ?', @id_parents, element_id, OwnershipType.find_by_name('all_entries').id, true )
		@ownerships_on_ownership = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_update = ?', @id_parents, element_id, OwnershipType.find_by_name('on_ownership').id, true )
		@ownerships_on_entry = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_update = ?', @id_parents, element_id, OwnershipType.find_by_name('on_entry').id, true ).pluck('id_element')
	end

	###
	#Control the rights of the user
	###

	# on index action
	def index_right(model)
		if @ownerships_all.any?
    	@elements = model.all
    else
    	if @ownerships_on_ownership.any?
				@elements = model.where('user_id = ? or id in (?)', current_user.id, @ownerships_on_entry)
			else
				if @ownerships_on_entry.any?
					@elements = model.where('id in (?)', @ownerships_on_entry)
				end
			end
    end
    @elements = @elements.try{ |e| e.paginate(page: params[:page], per_page: 20) }
	end

	# on update, edit and delete actions
	def modify_right(model)
		if @ownerships_all.any?
			@element = true
		else
			if @ownerships_on_ownership.any?
				@element = (model.find_by_user_id_and_id(current_user.id, params[:id]).nil? ? false : true)
			end
			if @ownerships_on_entry.any? && @ownerships_on_entry.include?(params[:id].to_i)
				@element = true
			end
		end
		redirect_to(root_path, notice: "Vous n'avez pas les droits nécessaires pour modifier l'élément.") unless @element
	end

	def group_modify_right
		if @ownerships_all.any?
			@element = true
		else
			if @ownerships_on_entry.any? && @ownerships_on_entry.include?(Group.find_by_url(params[:id]).id)
				@element = true
			end
		end
		redirect_to(root_path, notice: "Vous n'avez pas les droits nécessaires pour modifier l'élément.") unless @element
	end

	# buttons in the view
	def create?
		if signed_in?
			element_id ||= Element.find_by_name('admin/' + params[:controller]).id
			@id_parents = Parent.where('user_id = ?', current_user).pluck('parent_id')
			@id_parents.push(current_user.id)
			@ownerships ||= Ownership.where('user_id IN (?) AND element_id = ? AND right_create = ?', @id_parents, element_id, true )
			@ownerships.any?
		end
	end

	def edit?(element, controller = ('admin/' + params[:controller]))
		if signed_in?
			element_id ||= Element.find_by_name(controller).id
			@id_parents = Parent.where('user_id = ?', current_user).pluck('parent_id')
			@id_parents.push(current_user.id)
			@ownerships_all ||= Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_update = ?', @id_parents, element_id, OwnershipType.find_by_name('all_entries').id, true )
			@ownerships_on_entry ||= Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_update = ? AND id_element = ?', @id_parents, element_id, OwnershipType.find_by_name('on_entry').id, true, element.id)
			@ownerships_on_ownership = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_update = ?', @id_parents, element_id, OwnershipType.find_by_name('on_ownership').id, true )
			@ownerships_all.any? || @ownerships_on_entry.any? || (element.user_id == current_user.id if @ownerships_on_ownership.any? )
		end
	end

	def delete?(element, controller = ('admin/' + params[:controller]))
		if signed_in?
			element_id ||= Element.find_by_name(controller).id
			@id_parents = Parent.where('user_id = ?', current_user).pluck('parent_id')
			@id_parents.push(current_user.id)
			@ownerships_all ||= Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_delete = ?', @id_parents, element_id, OwnershipType.find_by_name('all_entries').id, true )
			@ownerships_on_entry ||= Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_delete = ? AND id_element = ?', @id_parents, element_id, OwnershipType.find_by_name('on_entry').id, true, element.id)
			@ownerships_on_ownership = Ownership.where('user_id IN (?) AND element_id = ? AND ownership_type_id = ? AND right_delete = ?', @id_parents, element_id, OwnershipType.find_by_name('on_ownership').id, true )
			@ownerships_all.any? || @ownerships_on_entry.any? || (element.user_id == current_user.id if @ownerships_on_ownership.any? )
		end
	end
end
