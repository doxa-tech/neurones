#!/bin/env ruby
# encoding: utf-8

class G::StylesController <  G::BaseController
	
	def show
		@style = G::Style.find(params[:id])
		@content = Sass::Engine.new(@style.content, :syntax => :scss, :style => :compressed)
	end
end
