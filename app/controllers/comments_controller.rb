#!/bin/env ruby
# encoding: utf-8

class CommentsController < Admin::BaseController
	before_filter :find_article, only: [:create, :new_subcomment]
	before_filter only: [:destroy, :edit] {|controller| controller.modify_right(Comment)}

	def index
		respond_to do |format|
    	format.html
    	format.json { render json: Datatable.new(view_context, Comment) }
  	end
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

	def new_subcomment
		@parent_comment = Comment.find(params[:id])
		@comment = @parent_comment.comments.new
		respond_to do |format|
			format.js
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
				format.js
			end
		else
			respond_to do |format|
				format.js { render 'create_error' }
			end
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

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		flash[:success] = "Commentaire supprimé."
		redirect_to article_path(@comment.article_id)
	end

	def individual_feed
		@comments = Comment.where('article_id = ?', params[:id])
	end


	private

	def find_article
		@article = Article.find(params[:article_id])
	end

end
