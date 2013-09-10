#!/bin/env ruby
# encoding: utf-8

module GroupsHelper
  
  def current_group
    @group ||= Group.find_by_url(params[:group_id])
  end

  def page_url(page_url)
  	"/" + current_group.url + "/" + page_url
  end
  
end