#!/bin/env ruby
# encoding: utf-8

class GalleriesController < ApplicationController

  def index
  	@galleries = Gallery.order('date DESC').page(params[:page]).per_page(8)
  end

  def show
  	@gallery = Gallery.find_by_slug(params[:id])
  end
end
