#!/bin/env ruby
# encoding: utf-8

class Admin::BaseController < ApplicationController
	before_filter :connected?, :index_rights
	layout 'admin'

	def connected?
		if !current_user.nil?
			@ownerships = Ownership.where('user_id = ? AND element_id = ?', current_user.id, Element.find_by_name(params[:controller]).id )
		else
			redirect_to root_path, notice: "Connectez-vous pour accéder à cette page."
		end
	end

	def index_rights
		@ownerships.each do |ownership|
			if ownership.ownership_type.name == 'all_entries' && ownership.right_read == true
				@right = true
			end
		end
		redirect_to(root_path, notice: "Vous n'avez pas les droits nécessaires.") unless @right == true
	end

	def show_rights
		@ownerships.each do |ownership|
			if ownership.ownership_type.name == 'all_entries' && ownership.right_read == true
				@right = true
			elsif ownership.ownership_type.name == 'on_entry'
				@right = true if ownership.id_element == params[:id]
			elsif ownership.ownership_type.name == 'on_ownership' && params[:controller] == 'admin/articles'
				current_user.articles.each do |article|
					@right = true if article.id == params[:id]
				end
			elsif ownership.ownership_type.name == 'on_ownership' && params[:controller] == 'admin/comments'
				current_user.comments.each do |comment|
					@right = true if comment.id == params[:id]
				end
			end
			redirect_to(root_path, notice: "Vous n'avez pas les droits nécessaires.") unless @right == true
		end
	end
end
