#!/bin/env ruby
# encoding: utf-8

class Admin::CategoriesController < Admin::BaseController
	before_filter only: [:index] {|controller| controller.index_right(Category)}
	before_filter only: [:edit] {|controller| controller.edit_right(Category)}
	before_filter only: [:destroy, :update] {|controller| controller.modify_right(Category)}

	def index
	 #see before_filter
	end

	def new 
		@element = Category.new
	end

	def create 
		@category = Category.new(params[:category])
		if @category.save
			flash[:success] = "Catégorie ajoutée"
			redirect_to admin_categories_path
		else
			render 'new'
		end
	end

	def edit
		#see before_filter
	end

	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(params[:category])
			flash[:success] = "Catégorie enregistrée"
			redirect_to admin_categories_path
		else
			render 'edit'
		end
	end

	def destroy
		Category.find(params[:id]).destroy
		flash[:success] = "Catégorie supprimée"
		redirect_to admin_categories_path
	end
end
