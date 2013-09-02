#!/bin/env ruby
# encoding: utf-8

class Admin::ArticlesController < Admin::BaseController
	before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(Article)}
	layout "application"

	def index
		@table = ArticlesTable.new(view_context)
	  respond_to do |format|
    	format.html { render layout: 'admin' }
    	format.js { render 'tables/sort' }
  	end
	end

	def new
		@article = current_user.articles.new(content: 'Contenu', title: 'Titre', subtitle: 'Sous-titre')
	end

	def create
		@article = current_user.articles.new(params[:article])
		if @article.save
			flash[:success] = "Article enregistré"
			redirect_to blog_path
		else
			render 'new'
		end
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update_attributes(params[:article])
			flash[:success] = "Article édité"
			redirect_to blog_path
		else
			render 'edit'
		end
	end

	def destroy
		Article.find(params[:id]).destroy
		flash[:success] = "Article supprimé"
		redirect_to admin_articles_path
	end
end
