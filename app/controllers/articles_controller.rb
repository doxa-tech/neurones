#!/bin/env ruby
# encoding: utf-8

class ArticlesController < ApplicationController

	def index
		@articles = Article.all
	end
	
end
