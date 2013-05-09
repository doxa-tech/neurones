#!/bin/env ruby
# encoding: utf-8

class Group::GroupsController < ApplicationController

	def index
		@groups = Group::Group.all
	end

end
