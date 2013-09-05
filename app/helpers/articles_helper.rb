#!/bin/env ruby
# encoding: utf-8

module ArticlesHelper

	def image_src(article)
		if article.image_url.nil?
			'/assets/blog/langoustine_1.jpg'
		else
			article.image_url
		end
	end


end