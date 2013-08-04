#!/bin/env ruby
# encoding: utf-8

class Group::Admin::GroupPagesController < ApplicationController
  
  def index
    @pages = current_group.pages
  end
  
  def edit
    @page = Group::Page.find(params[:id])
  end
  
end
