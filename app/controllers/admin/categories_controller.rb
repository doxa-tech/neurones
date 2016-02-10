#!/bin/env ruby
# encoding: utf-8

class Admin::CategoriesController < Admin::BaseController
	load_and_authorize

	def index
		@table = Table.new(self, Category, @categories)
	  @table.respond
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
	end

	def update
		if @category.update_attributes(params[:category])
			flash[:success] = "Catégorie enregistrée"
			redirect_to admin_categories_path
		else
			render 'edit'
		end
	end

	def destroy
		@category.destroy
		flash[:success] = "Catégorie supprimée"
		redirect_to admin_categories_path
	end
end
