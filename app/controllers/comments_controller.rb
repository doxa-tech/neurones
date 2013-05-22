#!/bin/env ruby
# encoding: utf-8

class CommentsController < ApplicationController
	before_filter :find_article

	def index
		@comments = Comment.where('user_id = ?', current_user.id).page(params[:page]).per_page(10)
	end

	def create
		params[:comment][:article_id] = @article.id
		@comment = current_user.comments.new(params[:comment])
		if @comment.save
			respond_to do |format|
      	format.html { redirect_to(article_path(@article)) }
      	format.js { render 'create_success' }
    	end
		else
			respond_to do |format|
      	format.html { render 'new' }
      	format.js { render 'create_error' }
    	end
		end
	end

	def comment_up
	end

	def comment_down
	end

	private

	def find_article
		@article = Article.find(params[:article_id])
	end

end
