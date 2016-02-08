#!/bin/env ruby
# encoding: utf-8

# text areas between comp_pages in the pages

class Admin::G::TextsController < Admin::G::BaseController

	def update
    @text = G::Text.find(params[:id])
    if @text.update_attributes(params[:g_text])
      respond_to do |format|
        format.html do
          flash[:success] = "Contenu enregistré")
          redirect_to edit_admin_group_g_page_path(current_group, @text.page)
        end
        format.js { render 'success' }
      end
    else
      respond_to do |format|
        format.html { render '/admin/g/pages/edit' }
        format.js { render 'error' }
      end
    end
  end

end
