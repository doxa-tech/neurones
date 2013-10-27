#!/bin/env ruby
# encoding: utf-8

class Admin::G::ModulesController < Admin::G::BaseController
  
  def index
    @modules = G::Module.where('module_type_id = ?', G::ModuleType.find_by_name('group').id )
  end

  # make modules available or not for a group
  # add a module in a comp_group or destroy a comp_group

  def activate
    @module = G::Module.find(params[:id])
    current_group.modules << @module.modules
    flash[:success] = "Module activé"
    redirect_to admin_group_g_modules_path(current_group)
  end
  
  def desactivate
    @module = G::Module.find(params[:id])
    G::CompGroup.where('group_id = ? and module_id in (?)', current_group.id, @module.modules.pluck(:id) ).destroy_all
    flash[:success] = "Module désactivé"
    redirect_to admin_group_g_modules_path(current_group)
  end
  
end
