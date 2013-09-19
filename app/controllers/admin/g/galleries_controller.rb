#!/bin/env ruby
# encoding: utf-8

class Admin::G::GalleriesController < Admin::G::BaseController
  before_filter { |controller| controller.module_activated?('galleries')}

	def index
		@table = GGalleriesTable.new(view_context, true)
    respond_to do |format|
      format.html { render layout: 'admin' }
      format.js { render 'tables/sort' }
    end
	end

	def new
		@gallery = current_group.galleries.new
	end

	def create
		@gallery = current_group.galleries.new(params[:g_gallery])
    if @gallery.save
      flash[:success] = "Galerie ajoutée"
      redirect_to edit_admin_group_g_gallery_path(current_group, @gallery)
    else
      render 'new' 
    end
	end

	def edit
		@gallery = G::Gallery.find(params[:id])
	end

	def update
		@gallery = G::Gallery.find(params[:id])
    if @gallery.update_attributes(params[:g_gallery])
      flash[:success] = "Galerie enregistrée"
      redirect_to edit_admin_group_g_gallery_path(current_group, @gallery)
    else
      render 'edit'
    end
	end

	def destroy
		@gallery = G::Gallery.find(params[:id])
    @gallery.paintings.each do |painting|
      painting.remove_image!
      painting.destroy
    end
    @gallery.destroy
    flash[:success] = "Galerie supprimée"
    redirect_to admin_group_g_galleries_path(current_group)
	end
end
