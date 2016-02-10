#!/bin/env ruby
# encoding: utf-8

class Admin::GalleriesController < Admin::BaseController
	load_and_authorize

	def index
		@table = Table.new(self, Gallery, @galleries)
    @table.respond
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
	end

	def update
    if @gallery.update_attributes(params[:gallery])
      flash[:success] = "Galerie enregistrée"
      redirect_to edit_admin_gallery_path(@gallery)
    else
      render 'edit'
    end
	end

	def destroy
    # remove the gallery's pictures
    @gallery.paintings.each do |painting|
      painting.remove_image!
      painting.destroy
    end
    @gallery.destroy
    flash[:success] = "Galerie supprimée"
    redirect_to admin_galleries_path
	end

end
