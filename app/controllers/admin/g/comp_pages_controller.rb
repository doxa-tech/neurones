#!/bin/env ruby
# encoding: utf-8

class Admin::G::CompPagesController < Admin::G::BaseController
  before_filter :find_page, only: [:up, :down]
  before_filter :is_first?, only: [:up]
  before_filter :is_last?, only: [:down]
  
  def new
    @page = current_group.pages.find_by_url(params[:page_id])
    @comp_page = G::CompPage.new
    @comp_page.comp_group_id = params[:comp_group_id]
    @comp_page.page_id = @page.id
    @comp_page.save
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def destroy
    @comp_page = G::CompPage.find(params[:id])
    @previous_text = G::Text.where('text_order < ? and page_id = ?', @comp_page.text.text_order, @comp_page.page_id).order(:text_order).last
    @previous_text.content += @comp_page.text.content
    @previous_text.save
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
      format.js { render 'switch'} 
    end
  end
  
  def down
    exchange_order
    respond_to do |format|
      format.html
      format.js { render 'switch'} 
    end
  end
  
  private
    
    def is_first?
      @comp_page_2 = @page.comp_pages.where('module_order < ?', @comp_page.module_order ).order(:module_order).last
      redirect_to edit_admin_group_g_page_path(current_group, @page) unless @comp_page_2
    end
    
    def is_last?
      @comp_page_2 = @page.comp_pages.where('module_order > ?', @comp_page.module_order ).order(:module_order).first
      redirect_to edit_admin_group_g_page_path(current_group, @page) unless @comp_page_2
    end
    
    def find_page
       @page = G::Page.find_by_url(params[:page_id])
       @comp_page = G::CompPage.find(params[:id])
    end
    
    def exchange_order
      comp_page_module_order = @comp_page.module_order
      comp_page_2_module_order = @comp_page_2.module_order
      @comp_page.update_attribute(:module_order, comp_page_2_module_order)
      @comp_page_2.update_attribute(:module_order, comp_page_module_order)

      @text = @comp_page.text
      @text_previous = @comp_page_2.text
      @text.update_attribute(:comp_page_id, @comp_page_2.id )
      @text_previous.update_attribute(:comp_page_id, @comp_page.id)
    end
  
end
