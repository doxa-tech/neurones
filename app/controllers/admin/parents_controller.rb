#!/bin/env ruby
# encoding: utf-8

class Admin::ParentsController < Admin::BaseController
	before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(Parent)}

	def index
		@table = ParentsTable.new(view_context)
	  respond_to do |format|
    	format.html
    	format.js { render 'tables/sort' }
  	end
	end

	def new 
		@parent = Parent.new
		@parent.user_id = params[:user_id]
	end

	def create
		@parent = Parent.new(params[:parent])
		if @parent.save
			flash[:success] = "Relation ajoutée"
			redirect_to admin_parents_path
		else
			render 'new'
		end
	end

	def edit
		@parent = Parent.find(params[:id])
	end

	def update
		@parent = Parent.find(params[:id])
		if @parent.update_attributes(params[:parent])
			flash[:success] = "Relation enregistrée"
			redirect_to admin_parents_path
		else
			render 'edit'
		end
	end

	def destroy
		Parent.find(params[:id]).destroy
		flash[:success] = "Relation supprimée"
		redirect_to admin_parents_path
	end
end
