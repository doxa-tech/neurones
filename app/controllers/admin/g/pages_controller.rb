#!/bin/env ruby
# encoding: utf-8

class Admin::G::PagesController < Admin::G::BaseController
  before_filter :is_index?, only: [:destroy]
  #before_filter :modify_index?, only: [:update]
  before_filter :find_page, only: [:up, :down]
  before_filter :is_first?, only: [:down]
  before_filter :is_last?, only: [:up]
  
  def index
    @pages = current_group.pages
  end
  
  def edit
    @page = current_group.pages.find_by_url(params[:id])
    @text = G::Text.find_by_page_id_and_text_order(@page.id, 1)
    render layout: 'group/application'
  end

  def update
    @page = current_group.pages.find_by_url(params[:id])
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

  def up
    exchange_order
  end

  def down
    exchange_order
  end

  private

  def find_page
    @page = current_group.pages.find_by_url(params[:id])
  end
    
  def is_first?
    @page_2 = current_group.pages.where('page_order < ?', @page.page_order ).order(:page_order).last
    redirect_to admin_group_g_pages_path(current_group) unless @page_2
  end
  
  def is_last?
    @page_2 = current_group.pages.where('page_order > ?', @page.page_order ).order(:page_order).first
    redirect_to admin_group_g_pages_path(current_group) unless @page_2
  end

  def exchange_order
    page_order = @page.page_order
    page_2_order = @page_2.page_order
    @page.update_attribute(:page_order, page_2_order)
    @page_2.update_attribute(:page_order, page_order)
    redirect_to admin_group_g_pages_path(current_group)
  end

  def is_index?
    @page = current_group.pages.find_by_url(params[:id])
    redirect_to admin_group_g_pages_path(current_group), notice: "Vous ne pouvez pas supprimer l'index" if @page.url == "index"
  end

  def modify_index?
    @page = current_group.pages.find_by_url(params[:id])
    if @page.url == "index" && params[:g_page][:url] != "index"
      redirect_to edit_admin_group_g_page_path(current_group, @page)
    end
  end
end
