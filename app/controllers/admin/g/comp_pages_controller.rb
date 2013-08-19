#!/bin/env ruby
# encoding: utf-8

class Admin::G::CompPagesController < Admin::G::BaseController
  before_filter :find_page, only: [:up, :down]
  before_filter :is_first?, only: [:up]
  before_filter :is_last?, only: [:down]
  
  def new
    @page = G::Page.find(params[:page_id])
    @page.comp_groups << G::CompGroup.find(params[:comp_group_id])
    @comp_page = G::CompPage.last
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def destroy
    @comp_page = G::CompPage.find(params[:id])
    @comp_page.destroy
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def up
    exchange_order
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def down
    exchange_order
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  private
    
    def is_first?
      @comp_page_2 = @page.comp_pages.where('module_order < ?', @comp_page.module_order ).order(:module_order).last
      redirect_to edit_group_admin_group_group_group_page_path(current_group, @page.id) unless @comp_page_2
    end
    
    def is_last?
      @comp_page_2 = @page.comp_pages.where('module_order > ?', @comp_page.module_order ).order(:module_order).first
      redirect_to edit_group_admin_group_group_group_page_path(current_group, @page.id) unless @comp_page_2
    end
    
    def find_page
       @page = G::Page.find(params[:page_id])
       @comp_page = G::CompPage.find(params[:id])
    end
    
    def exchange_order
      comp_page_id = @comp_page.module_order
      comp_page_previous_id = @comp_page_2.module_order
      @comp_page.module_order = comp_page_previous_id
      @comp_page_2.module_order = comp_page_id
      @comp_page.save
      @comp_page_2.save
    end
  
end
