#!/bin/env ruby
# encoding: utf-8

class Admin::G::ModulesController < Admin::G::BaseController
  
  def index
    @modules = G::Module.all
  end
  
  def activate
    current_group.modules << G::Module.find(params[:id])
    flash[:success] = "Module activé"
    redirect_to admin_group_g_modules_path(current_group)
  end
  
  def desactivate
    G::CompGroup.find_by_group_id_and_module_id(current_group.id, params[:id]).destroy
    flash[:success] = "Module désactivé"
    redirect_to admin_group_g_modules_path(current_group)
  end
  
end
