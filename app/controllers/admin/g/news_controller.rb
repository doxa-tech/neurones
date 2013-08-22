#!/bin/env ruby
# encoding: utf-8

class Admin::G::NewsController < Admin::G::BaseController

	def index
		respond_to do |format|
    	format.html
    	format.json { render json: Datatable.new(view_context, G::New, false) }
  	end
	end

	def new
		@new = current_group.news.new
	end

	def create
		@new = G::New.new(params[:g_new])
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
