#!/bin/env ruby
# encoding: utf-8

class Admin::GroupsController <Admin::BaseController

	def index
		@groups = Group.page(params[:page]).per_page(10)
	end

	def new
		@group = Group.new
	end

	def create
		@group = Group.new(params[:group])
    if @group.save
      flash[:success] = "Groupe ajoutée"
      redirect_to admin_groups_path
    else
      render 'new' 
    end
  end

  def edit
  	@group = Group.find(params[:id])
  end

  def update
  	@group = Group.find(params[:id])
  	if @group.update_attributes(params[:gallery])
      flash[:success] = "Groupe enregistrée"
      redirect_to admin_groups_path
    else
      render 'edit'
    end
  end

  def destroy 
  	@group = Group.find(params[:id])
    @group.destroy
    flash[:success] = "Groupe supprimée"
    redirect_to admin_groups_path
  end
end
