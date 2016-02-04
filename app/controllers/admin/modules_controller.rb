#!/bin/env ruby
# encoding: utf-8

class Admin::ModulesController < Admin::BaseController
	before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(G::Module)}

	def index
		@table = ModuleTable.new(self)
	  @table.respond
	end

	def new
		@module = G::Module.new
	end

	def create
		@module = @type.modules.new(params[:g_module])
		if @module.save
			flash[:success] = "Module ajouté"
			redirect_to admin_g_modules_path
		else
			render 'new'
		end
	end

	def edit
		@module = G::Module.find(params[:id])
	end

	def update
		@module = G::Module.find(params[:id])
		if @module.update_attributes(params[:g_module])
			flash[:success] = "Module enregistré"
			redirect_to admin_g_modules_path
		else
			render 'edit'
		end
	end

	def destroy
		G::Module.find(params[:id]).destroy
		flash[:success] = "Module supprimé"
		redirect_to admin_g_modules_path
	end
end
