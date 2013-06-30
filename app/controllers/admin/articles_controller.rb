#!/bin/env ruby
# encoding: utf-8

class Admin::ArticlesController < Admin::BaseController
	before_filter :update_ownerships, only: [:mercury_update]
	before_filter only: [:destroy, :edit, :mercury_update] {|controller| controller.modify_right(Article)}

	layout :layout_with_mercury

	def index
	  respond_to do |format|
    	format.html
    	format.json { render json: Datatable.new(view_context, Article) }
  	end
	end

	def new
		@article = current_user.articles.new(content: 'Contenu', title: 'Titre', subtitle: 'Sous-titre')
	end

	def create
		article = current_user.articles.new
  	article.title = params[:content][:article_title][:value]
  	article.content = params[:content][:article_content][:value]
  	article.subtitle = params[:content][:article_subtitle][:value]
  	article.category_id = params[:content][:article_category][:value]
  	#article.image = params[:content][:article_image][:value]
  	article.mercury_image_id = MercuryImage.find_by_image(params[:content][:article_image][:value].split('/').last)
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
  	article.image = params[:content][:article_image][:value]
  	article.save!
 	 	render text: '{"url":"/blog"}'
	end

	def destroy
		Article.find(params[:id]).destroy
		flash[:success] = "Article supprimé"
		redirect_to admin_articles_path
	end

	private 

  def layout_with_mercury
  	if !params[:mercury_frame] && params[:action] != 'index'
    	'mercury'
    else
    	'admin'
    end
  end
end
