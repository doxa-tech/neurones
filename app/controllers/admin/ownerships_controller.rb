#!/bin/env ruby
# encoding: utf-8

class Admin::OwnershipsController < Admin::BaseController
	before_filter only: [:index] {|controller| controller.index_right(Ownership)}

	def index
		#see before_filter
	end
end
