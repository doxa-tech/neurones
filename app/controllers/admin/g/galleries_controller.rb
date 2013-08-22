#!/bin/env ruby
# encoding: utf-8

class Admin::G::GalleriesController < Admin::G::BaseController

	def index
		respond_to do |format|
    	format.html
    	format.json { render json: Datatable.new(view_context, G::Gallery, false) }
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
