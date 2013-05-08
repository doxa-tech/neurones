#!/bin/env ruby
# encoding: utf-8

class Group::Admin::GroupsController < ApplicationController
	layout 'admin'

	def index
		@groups = Group::Group.page(params[:page]).per_page(10)
	end

	def new
		@group = Group::Group.new
	end

	def create
		@group = Group::Group.new(params[:group_group])
    if @group.save
      flash[:success] = "Groupe ajoutée"
      redirect_to admin_group_groups_path
    else
      render 'new' 
    end
  end

  def edit
  	@group = Group::Group.find(params[:id])
  end

  def update
  	@group = Group::Group.find(params[:id])
  	if @group.update_attributes(params[:group_group])
      flash[:success] = "Groupe enregistrée"
      redirect_to admin_group_groups_path
    else
      render 'edit'
    end
  end

  def destroy 
  	@group = Group::Group.find(params[:id])
    @group.destroy
    flash[:success] = "Groupe supprimée"
    redirect_to admin_group_groups_path
  end
end
