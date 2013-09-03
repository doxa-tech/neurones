#!/bin/env ruby
# encoding: utf-8

module Admin::TablesHelper
	include Admin::RightsHelper

	def sort_column(model = @model)
   model.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sortable(column, model = @model)
  	if model.reflect_on_association(column.gsub('_id', '').to_sym).nil?
		  title = model.human_attribute_name(column)
		  css_class = column == sort_column(model) ? "current #{sort_direction}" : nil
		  direction = column == sort_column(model) && sort_direction == "asc" ? "desc" : "asc"
		  link_to title, {:sort => column, :direction => direction}, {remote: true}
	 	else
	 		model.human_attribute_name(column)
	 	end
	end

	def f(element)
		'<td>' + element.to_s + '</td>'
	end

	def elements
		if @is_group == false
			index_ownerships
			if @ownerships_all.any?
				@elements = @model.order(sort_column + " " + sort_direction)
			else
				if @ownerships_on_ownership.any?
					@elements = @model.order(sort_column + " " + sort_direction).where('user_id = ? or id in (?)', current_user.id, @ownerships_on_entry)
				else
					if @ownerships_on_entry.any?
						@elements = @model.order(sort_column + " " + sort_direction).where('id in (?)', @ownerships_on_entry)
					end
				end
			end
		else
			@elements = @model.where('group_id = ?', current_group.id).order(sort_column + " " + sort_direction)
		end
		@elements = @elements.paginate(page: params[:page], per_page: 10)
		if params[:query].present?
			@elements = @elements.search(params[:query])
		end
		@elements
	end

	def build
		render 'tables/table', table: self, elements: elements
	end

	def url(element)
    "<td style='display:none;' class='url' data-url='#{element}'></td>"
  end
end