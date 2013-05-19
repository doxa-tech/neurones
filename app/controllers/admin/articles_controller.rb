#!/bin/env ruby
# encoding: utf-8

class Admin::ArticlesController < Admin::BaseController
	before_filter only: [:index] {|controller| controller.index_right(Article)}
	before_filter :mercury_update_right, only: [:mercury_update]
	before_filter only: [:destroy, :edit] {|controller| controller.modify_right(Article)}

	def index
		#see before_filter
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
  	article.image = params[:content][:article_image][:value]
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
  	article.save!
 	 	render text: '{"url":"/blog"}'
	end

	def destroy
		Article.find(params[:id]).destroy
		flash[:success] = "Article supprimé"
		redirect_to admin_articles_path
	end

	private 

	def mercury_update_right
		element_id = Element.find_by_name('admin/articles').id
		ownerships_all = Ownership.where('user_id = ? AND element_id = ? AND ownership_type_id = ? AND right_update = ?', current_user.id, element_id, OwnershipType.find_by_name('all_entries').id, true )
		ownerships_on_ownership = Ownership.where('user_id = ? AND element_id = ? AND ownership_type_id = ? AND right_update = ?', current_user.id, element_id, OwnershipType.find_by_name('on_ownership').id, true)
		ownerships_on_entry = Ownership.where('user_id = ? AND element_id = ? AND ownership_type_id = ? AND right_update = ?', current_user.id, element_id, OwnershipType.find_by_name('on_entry').id, true).select('id_element')
		if ownerships_all.any?
			element = true
		elsif ownerships_on_ownership.any?
			element = (Article.where('user_id = ? AND id = ?', current_user.id, params[:id]).first.nil?) ? false : true
		elsif ownerships_on_entry.any?
			ownerships_on_entry.each do |entry|
				if entry.id == params[:id]
					element = true
				end
			end
		end
		redirect_to(root_path, notice: "Vous n'avez pas les droits nécessaires pour modifier l'élément.") unless element
	end
end
