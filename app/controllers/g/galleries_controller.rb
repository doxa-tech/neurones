#!/bin/env ruby
# encoding: utf-8

class G::GalleriesController < G::BaseController
	before_filter { |controller| controller.module_activated?('galleries')}

	def show
    unless @gallery = G::Gallery.find_by_group_id_and_id(current_group.try(:id), params[:id])
      raise ActionController::RoutingError.new('Not Found')
    end
  end

end
