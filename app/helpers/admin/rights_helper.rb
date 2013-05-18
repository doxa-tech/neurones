#!/bin/env ruby
# encoding: utf-8

module Admin::RightsHelper
	# called by controllers on CRUD actions. Perform a redirect_to if unnecessary right

	# on index actions
	def index_right(element)
		if @ownerships_all.any?
			@elements = element.page(params[:page]).per_page(10)
		else
			if @ownerships_on_ownership.any?
				@elements = element.where('user_id = ?', current_user.id).page(params[:page]).per_page(10)
			end
			if @ownerships_on_entry.any?
				if @elements.nil?
					@elements = element.where(id: @ownerships_on_entry).page(params[:page]).per_page(10)
				else
					@elements = (@elements + element.where(id: @ownerships_on_entry)).paginate(per_page: 10)
				end
			end
		end
		redirect_to(root_path, notice: "Vous n'avez pas les droits nécessaires pour éditer l'élément.") if @elements.nil?
	end
	
	# on update and delete actions
	def modify_right(element)
		if @ownerships_all.any?
			@element = true
		elsif @ownerships_on_ownership.any?
			@element = (element.where('user_id = ? AND id = ?', current_user.id, params[:id]).first.nil?) ? false : true
		elsif @ownerships_on_entry.any?
			@ownerships_on_entry.each do |entry|
				if entry.id == params[:id]
					@element = true
				end
			end
		end
		redirect_to(root_path, notice: "Vous n'avez pas les droits nécessaires pour modifier l'élément.") unless @element
	end

end
