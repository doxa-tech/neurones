#!/bin/env ruby
# encoding: utf-8

class CommentsController < Admin::BaseController
	before_filter :find_article, only: [:create]
	before_filter only: [:index] {|controller| controller.index_right(Comment)}
	before_filter only: [:destroy, :edit] {|controller| controller.modify_right(Comment)}

	def index
		#see before_filter
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

	def up
		@comment = Comment.find(params[:id])
		@comment += 1
		@comment.save
		respond_to do |format|
			format.js { render 'vote' }
		end
	end

	def down
		@comment = Comment.find(params[:id])
		@comment -= 1
		@comment.save
		respond_to do |format|
			format.js { render 'vote' }
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		flash[:success] = "Commentaire supprimé."
		redirect_to article_path(@comment.article_id)
	end


	private

	def find_article
		@article = Article.find(params[:article_id])
	end

end
