#!/bin/env ruby
# encoding: utf-8

class Admin::ModulesController < Admin::BaseController
	load_and_authorize only: [:new, :create]

	def index
    @modules = load_and_authorize!(model: G::Module)
		@table = ModuleTable.new(self, @modules)
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
    load_and_authorize!(resource: @module)
	end

	def update
		@module = G::Module.find(params[:id])
    load_and_authorize!(resource: @module)
		if @module.update_attributes(params[:g_module])
			flash[:success] = "Module enregistré"
			redirect_to admin_g_modules_path
		else
			render 'edit'
		end
	end

	def destroy
    @module = G::Module.find(params[:id])
    load_and_authorize!(resource: @module)
		@module.destroy
		flash[:success] = "Module supprimé"
		redirect_to admin_g_modules_path
	end
end
