#!/bin/env ruby
# encoding: utf-8

class Admin::G::StylesController < Admin::G::BaseController
	def index
		@my_style = current_group.style
		@attributes = get_attributes
	end

	def update_stylesheet
		@style = G::Style.find(params[:id])
		update_attributes(@style)
		expire_page group_style_path(current_group, @style, format: 'css')
	end

	def themes
		@themes = G::Style.where('theme = ?', true)
	end

	def update_theme
		@theme = G::Style.find(params[:group][:style_id])
		current_group.style.update_attribute(:content, @theme.content)
		expire_page group_style_path(current_group, current_group.style, format: 'css')
		flash[:success] = "Thème changé"
		redirect_to admin_group_g_styles_path(current_group)
	end

	def edit
		@style = G::Style.find(params[:id])
	end

	def update
		@style = G::Style.find(params[:id])
		@style.update_attributes(params[:g_style])
		expire_page group_style_path(current_group, @style, format: 'css')
	end
end
