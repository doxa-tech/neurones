#!/bin/env ruby
# encoding: utf-8

class Admin::MercuryImagesController <  Admin::BaseController
  before_filter only: [:destroy] {|controller| controller.modify_right(MercuryImage)}
  before_filter only: [:index] do |controller|
    controller.index_ownerships
    controller.index_right(MercuryImage)
  end

  respond_to :json

  def index
    # see before_filter
  end

  def create
    @image = MercuryImage.new(params[:image])
    @image.save
    render text: "{\"image\":{\"url\":\"#{@image.image.to_s}\"}}"
  end

  def destroy
    @image = MercuryImage.find(params[:id])
    FileUtils.rm_rf("public/uploads/mercury_image/image/#{@image.id}")
    @image.destroy
    flash[:success] = "Image supprimée"
    redirect_to admin_mercury_images_path
  end
end
