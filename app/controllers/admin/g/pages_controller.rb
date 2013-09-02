#!/bin/env ruby
# encoding: utf-8

class Admin::G::PagesController < Admin::G::BaseController
  before_filter :is_index?, only: [:destroy]
  before_filter :modify_index?, only: [:update]
  
  def index
    @pages = current_group.pages
  end
  
  def edit
    @page = current_group.pages.find_by_url(params[:id])
    @text = G::Text.find_by_page_id_and_text_order(@page.id, 1)
    render layout: 'group/application'
  end

  def update
    if @page.update_attributes(params[:g_page])
      flash[:success] = "Page enregistrée"
      redirect_to edit_admin_group_g_page_path(current_group, @page)
    else 
      @text = G::Text.find_by_page_id_and_text_order(@page.id, 1)
      render 'edit'
    end
  end

  def new
  	@page = current_group.pages.new
  end

  def create
  	@page = current_group.pages.new(params[:g_page])
  	if @page.save
  		flash[:success] = "Page ajoutée"
  		redirect_to edit_admin_group_g_page_path(current_group, @page)
  	else
  		render 'new'
  	end
  end

  def destroy
    flash[:success] = "Page supprimée"
    redirect_to admin_group_g_pages_path(current_group)
  end

  private

  def is_index?
    @page = current_group.pages.find_by_url(params[:id])
    redirect_to admin_group_g_pages_path(current_group) if @page.url == "index"
  end

  def modify_index?
    @page = current_group.pages.find_by_url(params[:id])
    if @page.url == "index"
      redirect_to edit_admin_group_g_page_path(current_group, @page) unless params[:g_page][:url] != "index"
    end
  end
end
