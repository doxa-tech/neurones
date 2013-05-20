#!/bin/env ruby
# encoding: utf-8

class ArticlesController < ApplicationController

	def index
		if params[:auteur]
			@articles = Article.where('user_id = ?', params[:auteur].to_i)
		else
			@articles = Article.all
		end
	end
	
end
