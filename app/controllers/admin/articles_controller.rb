#!/bin/env ruby
# encoding: utf-8

class Admin::ArticlesController < Admin::BaseController
	layout 'application'

	def index
		@articles = Article.page(params[:page]).per_page(10)
	end

	def new
		@article = Article.new
	end

	def create
		article = Article.new
  	article.title = params[:content][:article_title][:value]
  	article.content = params[:content][:article_content][:value]
  	article.subtitle = params[:content][:article_subtitle][:value]
  	article.user_id = @current_user.id
  	article.category_id = params[:content][:article_category][:value]
  	article.save!
 	 	render text: '{"url":"/blog"}'
	end

	def edit
		@article = Article.find(params[:id])
	end

	def mercury_update
		article = Article.find(params[:id])
  	article.title = params[:content][:article_title][:value]
  	article.content = params[:content][:article_content][:value]
  	article.subtitle = params[:content][:article_subtitle][:value]
  	article.category_id = params[:content][:article_category][:value]
  	article.save!
 	 	render text: '{"url":"/blog"}'
	end

	def destroy
		Article.find(params[:id]).destroy
		flash[:success] = "Article supprimé"
		redirect_to admin_articles_path
	end
end
