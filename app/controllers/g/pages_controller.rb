#!/bin/env ruby
# encoding: utf-8

class G::PagesController < G::BaseController

  def show
  	# seek the requested page
  	if @page = G::Page.find_by_group_id_and_url(current_group.try(:id), (params[:id] or "index"))
  		@text = G::Text.find_by_page_id_and_text_order(@page.id, 1)
  	else
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
