#!/bin/env ruby
# encoding: utf-8

class Group::GroupPagesController < ApplicationController
  layout 'group/application'
  
  def show
    unless @page = Group::Page.find_by_group_id_and_url(current_group.try(:id), params[:id].blank? ? "index" : params[:id])
      render 'public/404'
    end
  end
end
