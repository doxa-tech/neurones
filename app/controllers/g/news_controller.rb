#!/bin/env ruby
# encoding: utf-8

class G::NewsController < G::BaseController
	before_filter { |controller| controller.module_activated?('news')}

	def show
    unless @new = G::New.find_by_group_id_and_id(current_group.try(:id), params[:id])
      render 'public/404'
    end
  end
end
