#!/bin/env ruby
# encoding: utf-8

class G::StylesController <  G::BaseController

	caches_page :show
	
	def show
		@style = G::Style.find(params[:id])
		@content = Sass::Engine.new(@style.content, :syntax => :scss, :style => :compressed)
	end
end
