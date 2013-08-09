#!/bin/env ruby
# encoding: utf-8

class Admin::Group::PagesController < Admin::Group::BaseController
  
  def index
    @pages = current_group.pages
  end
  
  def edit
    @page = Group::Page.find(params[:id])
  end
  
end
