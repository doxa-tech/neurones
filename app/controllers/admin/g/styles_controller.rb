#!/bin/env ruby
# encoding: utf-8

class Admin::G::StylesController < Admin::G::BaseController
	def index
		@styles = G::Style.all
		@my_style = current_group.style
		@attributes = get_attributes
	end

	def update
		update_attributes
	end
end
