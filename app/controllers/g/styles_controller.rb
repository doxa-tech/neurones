#!/bin/env ruby
# encoding: utf-8

class G::StylesController <  G::BaseController

	caches_page :show

	def show
		@style = G::Style.find(params[:id])
		content = "html body #group_container { #{@style.content} }"
		@content = Sass::Engine.new(content, :syntax => :scss, :style => :compressed)
	end

end
