#!/bin/env ruby
# encoding: utf-8

class GroupsController < ApplicationController

	def index
		@groups = Group.includes(:canton, :style)
	end

end
