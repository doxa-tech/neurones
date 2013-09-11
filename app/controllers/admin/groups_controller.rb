#!/bin/env ruby
# encoding: utf-8

class Admin::GroupsController < Admin::BaseController
  before_filter only: [:destroy, :edit, :update] {|controller| controller.modify_right(Group)}
  before_filter :activated?, only: [:activation, :activate]
  layout 'group/admin'

	def index
		respond_to do |format|
      format.html
      format.json { render json: GroupsDatatable.new(view_context) }
    end
	end

	def new
		@group = Group.new
	end

	def create
		@group = Group.new(params[:group])
    @group.url = SecureRandom.uuid
    if @group.save
      flash[:success] = "Groupe ajoutée"
      redirect_to admin_groups_path
    else
      render 'new' 
    end
  end

  def edit
  	@group = Group.find_by_url(params[:id])
  end

  def update
  	@group = Group.find_by_url(params[:id])
  	if @group.update_attributes(params[:group])
      flash[:success] = "Groupe enregistrée"
      redirect_to admin_groups_path
    else
      render 'edit'
    end
  end

  def destroy 
  	@group = Group.find_by_url(params[:id])
    @group.destroy
    flash[:success] = "Groupe supprimée"
    redirect_to admin_groups_path
  end
  
  def activation
  end
  
  def activate
    @group.url = params[:group][:url]
    if @group.valid?
      @group.website_activated = true
      @group.save
      @group.pages.create(page_order: 1, url: "index", name: "Index")
      flash[:success] = "Site activé"
      redirect_to edit_admin_group_path(@group)
    else
      render 'activation'
    end
  end

  private

  def activated?
    @group = Group.find(params[:id])
    redirect_to edit_admin_group_path(@group) unless !@group.website_activated
  end
	
end