#!/bin/env ruby
# encoding: utf-8

class Admin::ArticlesController < Admin::BaseController
	before_filter only: [:index] {|controller| controller.index_right(Article)}
	before_filter only: [:edit] {|controller| controller.edit_right(Article)}
	before_filter only: [:destroy, :mercury_update] {|controller| controller.modify_right(Article)}

	def index
		#see before_filter
	end

	def new
		@element = current_user.articles.new(content: 'Contenu', title: 'Titre', subtitle: 'Sous-titre')
	end

	def create
		article = current_user.articles.new
  	article.title = params[:content][:article_title][:value]
  	article.content = params[:content][:article_content][:value]
  	article.subtitle = params[:content][:article_subtitle][:value]
  	article.category_id = params[:content][:article_category][:value]
  	article.image = params[:content][:article_image][:value]
  	article.save!
 	 	render text: '{"url":"/blog"}'
	end

	def edit
		#see before_filter
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
