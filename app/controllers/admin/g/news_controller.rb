#!/bin/env ruby
# encoding: utf-8

class Admin::G::NewsController < Admin::G::BaseController
	before_filter { |controller| controller.module_activated?('news')}

	def index
		@table = GNewsTable.new(view_context, true)
	  respond_to do |format|
    	format.html { render layout: 'admin' }
    	format.js { render 'tables/sort' }
  	end
	end

	def new
		@new = current_group.news.new
	end

	def create
		@new = current_group.news.new(params[:g_new])
    if @new.save
      flash[:success] = "New ajoutée"
      redirect_to admin_group_g_news_path(current_group)
    else
      render 'new' 
    end
	end

	def edit
		@new = G::New.find(params[:id])
	end

	def update
		@new = G::New.find(params[:id])
    if @new.update_attributes(params[:g_new])
      flash[:success] = "New enregistrée"
      redirect_to admin_group_g_news_path(current_group)
    else
      render 'edit'
    end
	end

	def destroy
		G::New.find(params[:id]).destroy
    flash[:success] = "New supprimée"
    redirect_to admin_group_g_news_path(current_group)
	end
end
