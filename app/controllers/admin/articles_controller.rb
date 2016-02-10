#!/bin/env ruby
# encoding: utf-8

class Admin::ArticlesController < Admin::BaseController
	load_and_authorize

	def index
		@table = ArticleTable.new(self, @articles)
	  @table.respond
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
	end

	def update
		if @article.update_attributes(params[:article])
			flash[:success] = "Article édité"
			redirect_to blog_path
		else
			render 'edit'
		end
	end

	def destroy
		@article.destroy
		flash[:success] = "Article supprimé"
		redirect_to admin_articles_path
	end
end
