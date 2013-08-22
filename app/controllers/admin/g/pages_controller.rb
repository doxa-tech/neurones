#!/bin/env ruby
# encoding: utf-8

class Admin::G::PagesController < Admin::G::BaseController
  
  def index
    @pages = current_group.pages
  end
  
  def edit
    @page = G::Page.find_by_url(params[:id])
  end

  def update
    # TODO
  end

  def new
  	@page = current_group.pages.new
  end

  def create
  	@page = current_group.pages.new(params[:g_page])
  	if @page.save
  		flash[:success] = "Page ajoutée"
  		redirect_to edit_admin_group_g_page_path(current_group, @page.id)
  	else
  		render 'new'
  	end
  end

  def destroy
    G::Page.find_by_url(params[:id]).destroy
    flash[:success] = "Page supprimée"
    redirect_to admin_group_g_pages_path(current_group)
  end
end
