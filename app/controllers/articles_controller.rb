#!/bin/env ruby
# encoding: utf-8

class ArticlesController < ApplicationController

	def likes
		@article = Article.find(params[:id])
		@article.likes += 1
		@article.save
		respond_to do |format|
			format.js
    end
	end

	def index
		if params[:auteur]
			@articles = Article.where('user_id = ?', params[:auteur].to_i)
		else
			@articles = Article.all
		end
	end

	def show
		@article = Article.find(params[:id])
	end
	
end
