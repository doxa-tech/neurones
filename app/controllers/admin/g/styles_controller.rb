#!/bin/env ruby
# encoding: utf-8

class Admin::G::StylesController < Admin::G::BaseController
	def index
		@my_style = current_group.style
		@attributes = get_attributes
	end

	def update_stylesheet
		update_attributes
	end

	def themes
		@themes = G::Style.where('theme = ?', true)
	end

	def update_theme
		@theme = G::Style.find(params[:group][:style_id])
		current_group.style.update_attribute(:content, @theme.content)
		expire_page group_g_style_path(current_group, current_group.style)
	end

	def edit
		@style = G::Style.find(params[:id])
	end

	def update
		@style = G::Style.find(params[:id])
		@style.update_attributes(params[:g_style])
		expire_page group_style_path(current_group, @style)
	end
end
