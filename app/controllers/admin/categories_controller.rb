#!/bin/env ruby
# encoding: utf-8

class Admin::CategoriesController < Admin::BaseController
	before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(Category)}

	def index
		respond_to do |format|
    	format.html
    	format.json { render json: Datatable.new(view_context, Category) }
  	end
	end

	def new 
		@category = Category.new
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
		@category = Category.find(params[:id])
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
