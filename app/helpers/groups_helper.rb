#!/bin/env ruby
# encoding: utf-8

module GroupsHelper
  
  def current_group
    @group ||= Group::Group.find_by_url(params[:group_group_id])
  end
  
end