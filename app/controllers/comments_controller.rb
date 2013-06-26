#!/bin/env ruby
# encoding: utf-8

class CommentsController < Admin::BaseController
	before_filter :find_article, only: [:create, :new_subcomment]
	before_filter only: [:destroy, :edit] {|controller| controller.modify_right(Comment)}

	def index
		respond_to do |format|
    	format.html
    	format.json { render json: CommentsDatatable.new(view_context) }
  	end
	end

	def create
		params[:comment][:article_id] = @article.id
		@comment = current_user.comments.new(params[:comment])
		if @comment.save
			respond_to do |format|
      	format.html { redirect_to(article_path(@article)) }
      	format.js { render 'success' }
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
				format.html { redirect_to(article_path(@article)) }
				format.js { render 'success' }
			end
		else
			respond_to do |format|
				format.html { render 'articles/show' }
				format.js { render 'error' }
			end
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		flash[:success] = "Commentaire supprimé."
		redirect_to article_path(@comment.article_id)
	end

	def new_subcomment
		@parent_comment = Comment.find(params[:id])
		@comment = @parent_comment.comments.new(article_id: params[:article_id])
		respond_to do |format|
			format.html { render 'articles/show' }
			format.js
		end
	end

	def more_subcomments
		@subcomments = Comment.where('comment_id = ?', params[:id]).limit(Comment.where('comment_id = ?', params[:id]).count()).offset(3)
		respond_to do |format|
			format.js
		end
	end


	def up
		@comment = Comment.find(params[:id])
		cookies.permanent['comment_votes'] = "" if !cookies['comment_votes']
		if !cookies['comment_votes'].split('&').include?(@comment.id.to_s)
			@comment.thumbup += 1
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

	def down
		@comment = Comment.find(params[:id])
		cookies.permanent['comment_votes'] = "" if !cookies['comment_votes']
		if !cookies['comment_votes'].split('&').include?(@comment.id.to_s)
			@comment.thumbup -= 1
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

end
