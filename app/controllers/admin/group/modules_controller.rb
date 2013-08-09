#!/bin/env ruby
# encoding: utf-8

class Admin::Group::ModulesController < Admin::Group::BaseController
  
  def index
    @modules = Group::Module.all
  end
  
  def activate
    current_group.modules << Group::Module.find(params[:id])
    flash[:success] = "Module activé"
    redirect_to admin_group_group_modules_path(current_group)
  end
  
  def desactivate
    Group::CompGroup.find_by_group_id_and_module_id(current_group.id, params[:id]).destroy
    flash[:success] = "Module désactivé"
    redirect_to admin_group_group_modules_path(current_group)
  end
  
end
