#!/bin/env ruby
# encoding: utf-8

class Admin::G::CompPagesController < Admin::G::BaseController
  before_filter :find_page, only: [:up, :down]
  before_filter :is_first?, only: [:up]
  before_filter :is_last?, only: [:down]
  
  def new
    @page = G::Page.find(params[:page_id])
    @comp_page = G::CompPage.new
    @comp_page.comp_group_id = params[:comp_group_id]
    @comp_page.page_id = @page.id
    if @comp_page.comp_group.module.name == "texts"
      @comp_page.content = "Ici votre contenu"
    end
    @comp_page.save
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @comp_page = G::CompPage.find(params[:id])
    if @comp_page.update_attributes(params[:g_comp_page])
      respond_to do |format|
        format.html { (flash[:success] = "Contenu enregistré") ; redirect_to(edit_admin_group_g_page_path(current_group, @comp_page.page)) }
        format.js { render 'success' }
      end
    else
      respond_to do |format|
        format.html { render '/admin/g/pages/edit' }
        format.js { render 'error' }
      end
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
