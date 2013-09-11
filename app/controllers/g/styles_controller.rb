#!/bin/env ruby
# encoding: utf-8

class G::StylesController <  G::BaseController

	caches_page :show
	
	def show
		@style = G::Style.find(params[:id])
		pre_css = "html{min-height: 100%; position: relative; } body { height: 100%;}"
		content = pre_css + 'html body #group_container { ' + @style.content + ' }'
		@content = Sass::Engine.new(content, :syntax => :scss, :style => :compressed, :cache_location => './sass_cache', :cache => true)
	end

end
