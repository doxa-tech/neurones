#!/bin/env ruby
# encoding: utf-8

class Admin::Group::GroupsController < Admin::BaseController
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
  	#render layout: 'group/admin'
  end

  def update
  	@group = Group::Group.find_by_url(params[:id])
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
  
  def activation
    @group = Group::Group.find(params[:id])
  end
  
  def activate
    @group = Group::Group.find(params[:id])
    @group.url = params[:group_group][:url]
    @group.website_activated = true
    if @group.save
      @group.pages.create(content: "Modifier cette page dans votre espace administration.", order: 1, url: "index", name: "Index")
      @group.modules << Group::Module.find_by_name("texts")
      flash[:success] = "Site activé"
      redirect_to edit_admin_group_group_path(@group.id)
    else
      render 'activation'
    end
  end
	
end
