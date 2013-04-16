#!/bin/env ruby
# encoding: utf-8

class PagesController < ApplicationController

	def home
		@page = Page.find_by_name('home')
		@event = Event.first
		@article = Article.first
		@groups = Group.all 
	end

	def plus
		
	end

	def presentation
		@page = Page.find_by_name('presentation')
	end

	def contact
		@page = Page.find_by_name('contact')
	end
end
