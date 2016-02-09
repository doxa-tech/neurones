#!/bin/env ruby
# encoding: utf-8

class Admin::G::PaintingsController < Admin::G::BaseController
	before_filter :find_gallery

  def new
  	@painting = G::Painting.new
  end

  def create
    @painting = @gallery.paintings.new(params[:painting])
    unless @painting.save
      render nothing: true, status: 415
    end
  end

  def destroy
  	@painting = G::Painting.find(params[:id])
    @painting.remove_image!
    @painting.destroy
    flash[:success] = "Photo supprimée"
    redirect_to edit_admin_group_g_gallery_path(current_group, @gallery)
  end

  private

  def find_gallery
  	@gallery = G::Gallery.find(params[:gallery_id])
  end
end
