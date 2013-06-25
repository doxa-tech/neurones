#!/bin/env ruby
# encoding: utf-8

class Group::Admin::GroupsController < Admin::BaseController
  before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(Group::Group)}
  layout 'group/admin'

	def index
		respond_to do |format|
      format.html
      format.json { render json: Datatable.new(view_context, Group::Group) }
    end
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
