#!/bin/env ruby
# encoding: utf-8

class ArticlesController < ApplicationController

	def likes
		if !cookies['article_vote_' + params[:id]]
			@article = Article.find(params[:id])
			@article.likes += 1
			@article.save
			cookies['article_vote_' + params[:id]] = @article.id
			respond_to do |format|
				format.js
	    end
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
