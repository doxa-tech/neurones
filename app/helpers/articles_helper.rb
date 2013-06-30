#!/bin/env ruby
# encoding: utf-8

module ArticlesHelper

	def image_src(article)
		if article.mercury_image_id.nil?
			'/assets/blog/langoustine_1.jpg'
		else
			article.mercury_image.image.url
		end
	end


end