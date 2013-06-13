#!/bin/env ruby
# encoding: utf-8

class Admin::BaseController < ApplicationController
	before_filter :connected?
	layout 'admin'

	def connected?
		if !current_user.nil?
			element_id = Element.find_by_name(params[:controller]).id
			@id_parents = Parent.where('user_id = ?', current_user).pluck('user_id')
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
end
