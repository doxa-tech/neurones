#!/bin/env ruby
# encoding: utf-8

class Admin::BaseController < ApplicationController
	# control the ownerships
	before_filter :connected?
	layout 'admin'
end
