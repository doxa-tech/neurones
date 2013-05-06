#!/bin/env ruby
# encoding: utf-8

class Admin::ArticlesController < Admin::BaseController

	def index
		@articles = Article.page(params[:page]).per_page(10)
	end

	def new
		@article = Article.new
	end

	def create
		params[:article][:author] = @current_user.name
		@article = Article.new(params[:article])
		if @article.save
			flash[:success] = "Article ajouté"
			redirect_to admin_articles_path
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
			flash[:success] = 'Article enregistré'
			redirect_to admin_articles_path 
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
