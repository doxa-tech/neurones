#!/bin/env ruby
# encoding: utf-8

module Admin::TablesHelper

	def sort_column(model = @model)
   model.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sortable(column, options={})
	  title = (options[:title] or column.titleize)
	  model = (options[:model] or @model)
	  css_class = column == sort_column(model) ? "current #{sort_direction}" : nil
	  direction = column == sort_column(model) && sort_direction == "asc" ? "desc" : "asc"
	  link_to title, {:sort => column, :direction => direction}, {remote: true}
	end

	def f(element)
		'<td>' + element.to_s + '</td>'
	end

	def elements
		@elements = @model.order(sort_column + " " + sort_direction)
		if params[:query].present?
			@elements = @elements.search(params[:query])
		end
		@elements
	end

	def build
		render 'tables/table', model: @model, data: data
	end

	def url(element)
    "<div class='url' data-url='#{element}'></div>"
  end

end