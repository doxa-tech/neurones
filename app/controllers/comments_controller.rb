#!/bin/env ruby
# encoding: utf-8

class CommentsController < ApplicationController
	before_filter :connected?, only: [:index, :create, :edit, :update, :destroy, :new_subcomment]
	before_filter :find_article, only: [:create, :new_subcomment]
	before_filter only: [:destroy, :edit] {|controller| controller.modify_right(Comment)}

	layout 'admin', only: [:index]

	def index
    @comments = Comment.where(user_id: current_user.id)
		@table = CommentTable.new(self, @comments, buttons: false)
	  @table.respond
	end

	def create
		params[:comment][:article_id] = @article.id
		@comment = current_user.comments.new(params[:comment])
		if @comment.save
			respond_to do |format|
      	format.html { redirect_to article_path(@article) }
      	format.js
    	end
		else
			respond_to do |format|
      	format.html { render 'articles/show' }
      	format.js { render 'error' }
    	end
		end
	end

	def edit
		@comment = Comment.find(params[:id])
		respond_to do |format|
			format.js
		end
	end

	def update
		@comment = Comment.find(params[:id])
		if @comment.update_attributes(params[:comment])
			flash[:success] = 'Commentaire enregistré'
			respond_to do |format|
				format.html { redirect_to article_path(@article) }
				format.js
			end
		else
			respond_to do |format|
				format.html { render 'articles/show' }
				format.js { render 'update_error' }
			end
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		flash[:success] = "Commentaire supprimé."
		redirect_to article_path(@comment.article_id)
	end

	# display a form to add a subcomment

	def new_subcomment
		@parent_comment = Comment.find(params[:id])
		@comment = @parent_comment.comments.new(article_id: params[:article_id])
		respond_to do |format|
			format.html { render 'articles/show' }
			format.js
		end
	end

	# display more comment's subcomments

	def more_subcomments
    comments = Comment.where(comment_id: params[:id])
		@subcomments = comments.limit(comments.count).offset(3)
		respond_to do |format|
			format.js
		end
	end


	def up
		vote(1)
	end

	def down
		vote(-1)
	end

	# atom feed
	def article_comments_feed
		@comments = Comment.where('article_id = ?', params[:article_id].to_i)
		@article = Article.find(params[:article_id].to_i)
	end

	def subcomments_feed
		@subcomments = Comment.where('comment_id = ?', params[:id])
		@comment = Comment.find(params[:id])
		@article = Article.find(params[:article_id])
	end

	private

	def find_article
		@article = Article.find(params[:article_id])
	end

  def vote(n)
    @comment = Comment.find(params[:id])
		cookies.permanent['comment_votes'] = "" if !cookies['comment_votes']
		if !cookies['comment_votes'].split('&').include?(@comment.id.to_s)
			@comment.thumbup += n
			@comment.save
			cookies.permanent['comment_votes'] = cookies['comment_votes'].split('&') + [@comment.id]
			respond_to do |format|
				format.js { render 'vote' }
			end
		else
	  	respond_to do |format|
				format.js { render 'voted' }
	    end
		end
  end

end
