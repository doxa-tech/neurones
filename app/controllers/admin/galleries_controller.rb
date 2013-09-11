#!/bin/env ruby
# encoding: utf-8

class Admin::GalleriesController < Admin::BaseController
	before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(Gallery)}

	def index
		respond_to do |format|
    	format.html
    	format.json { render json: Datatable.new(view_context, Gallery) }
  	end
	end

	def new
		@gallery = Gallery.new
	end

	def create
		@gallery = Gallery.new(params[:gallery])
    if @gallery.save
      flash[:success] = "Galerie ajoutée"
      redirect_to edit_admin_gallery_path(@gallery)
    else
      render 'new' 
    end
	end

	def edit
		@gallery = Gallery.find(params[:id])
	end

	def update
		@gallery = Gallery.find(params[:id])
    if @gallery.update_attributes(params[:gallery])
      flash[:success] = "Galerie enregistrée"
      redirect_to edit_admin_gallery_path(@gallery)
    else
      render 'edit'
    end
	end

	def destroy
		@gallery = Gallery.find(params[:id])
    @gallery.paintings.each do |painting|
      painting.remove_image!
      painting.destroy
    end
    @gallery.destroy
    flash[:success] = "Galerie supprimée"
    redirect_to admin_galleries_path
	end

end
