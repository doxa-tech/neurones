#!/bin/env ruby
# encoding: utf-8

module Admin::DatatablesHelper

	def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @model.count,
      iTotalDisplayRecords: elements.total_entries,
      aaData: data
    }
  end

  def elements
    @elements ||= fetch_elements
  end

  def fetch_elements
  	if @ownerships_all.any?
    	elements = @model.order("#{sort_column} #{sort_direction}")
    else
    	if @ownerships_on_ownership.any?
				elements = @model.order("#{sort_column} #{sort_direction}").where('user_id = ? or id in (?)', current_user.id, @ownerships_on_entry)
			else
				if @ownerships_on_entry.any?
					elements = @model.order("#{sort_column} #{sort_direction}").where('id in (?)', @ownerships_on_entry)
				end
			end
    end
    elements = elements.paginate(page: page, per_page: per_page)
    if params[:sSearch].present?
      elements = elements.where(search_request, search: "%#{params[:sSearch]}%")
    end
    elements
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = fetch_columns
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def fetch_columns
  	@model.columns.map do |column|
  		column.name
  	end
  end

  def search_request
  	request = ""
		fetch_columns.each do |column|
			request = request + ' ' + column + ' like :search or '
		end
		request += ' id like :search'
	end
end