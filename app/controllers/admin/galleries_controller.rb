#!/bin/env ruby
# encoding: utf-8

class Admin::GalleriesController < Admin::BaseController
	before_filter only: [:index] {|controller| controller.index_right(Gallery)}
	before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(Gallery)}

	def index
		#see before_filter
	end

	def new
		@gallery = Gallery.new
	end

	def create
		@gallery = Gallery.new(params[:gallery])
    if @gallery.save
      flash[:success] = "Galerie ajoutée"
      redirect_to edit_admin_gallery_path(@gallery.id)
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
      redirect_to edit_admin_gallery_path(@gallery.id)
    else
      render 'edit'
    end
	end

	def destroy
		@gallery = Gallery.find(params[:id])
    FileUtils.rm_rf("public/uploads/painting/image/#{@gallery.id}")   
    @gallery.destroy
    flash[:success] = "Galerie supprimée"
    redirect_to admin_galleries_path
	end

end
