#!/bin/env ruby
# encoding: utf-8

class Admin::BaseController < ApplicationController
	before_filter :connected?
	layout 'admin'

	def connected?
		element_id = Element.find_by_name(params[:controller]).id
		if !current_user.nil?
			case params[:action]
			when 'index'
				@ownerships_all = Ownership.where('user_id = ? AND element_id = ? AND ownership_type_id = ? AND right_read = ?', current_user.id, element_id, OwnershipType.find_by_name('all_entries').id, true )
				@ownerships_on_ownership = Ownership.where('user_id = ? AND element_id = ? AND ownership_type_id = ? AND right_read = ?', current_user.id, element_id, OwnershipType.find_by_name('on_ownership').id, true )
				@ownerships_on_entry = Ownership.where('user_id = ? AND element_id = ? AND ownership_type_id = ? AND right_read = ?', current_user.id, element_id, OwnershipType.find_by_name('on_entry').id, true ).select('id_element')
			when 'new' || 'create'
				@ownerships_all = Ownership.where('user_id = ? AND element_id = ? AND ownership_type_id = ? AND right_create = ?', current_user.id, element_id, OwnershipType.find_by_name('all_entries').id, true )
				redirect_to root_path, notice: "Vous n'avez pas le droit d'ajouter un article." unless @ownerships_all.any?
			when 'edit' || 'update'
				@ownerships_all = Ownership.where('user_id = ? AND element_id = ? AND ownership_type_id = ? AND right_update = ?', current_user.id, element_id, OwnershipType.find_by_name('all_entries').id, true )
				@ownerships_on_ownership = Ownership.where('user_id = ? AND element_id = ? AND ownership_type_id = ? AND right_update = ?', current_user.id, element_id, OwnershipType.find_by_name('on_ownership').id, true)
				@ownerships_on_entry = Ownership.where('user_id = ? AND element_id = ? AND ownership_type_id = ? AND right_update = ?', current_user.id, element_id, OwnershipType.find_by_name('on_entry').id, true).select('id_element')
			when 'destroy'
				@ownerships_all = Ownership.where('user_id = ? AND element_id = ? AND ownership_type_id = ? AND right_delete = ?', current_user.id, element_id, OwnershipType.find_by_name('all_entries').id, true )
				@ownerships_on_ownership = Ownership.where('user_id = ? AND element_id = ? AND ownership_type_id = ? AND right_delete = ?', current_user.id, element_id, OwnershipType.find_by_name('on_ownership').id, true )
				@ownerships_on_entry = Ownership.where('user_id = ? AND element_id = ? AND ownership_type_id = ? AND right_delete = ?', current_user.id, element_id, OwnershipType.find_by_name('on_entry').id, true ).select('id_element')
			end
		else
			redirect_to root_path, notice: "Connectez-vous pour accéder à cette page."
		end
	end
end
