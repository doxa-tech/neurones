#!/bin/env ruby
# encoding: utf-8

module ArticlesHelper

	# Provide the article's image path or the default one
	#
	# * *Args*		:
	# 	- an article
	# * *Returns*	:
	# 	- the article's image path
	def image_src(article)
		if article.image_url.nil?
			image_path 'blog/langoustine_1.jpg'
		else
			article.image_url
		end
	end


end
