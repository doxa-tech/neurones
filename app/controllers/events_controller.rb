#!/bin/env ruby
# encoding: utf-8

class EventsController < ApplicationController

	def index
		@events = Event.where('date > ?', Time.zone.now).order('date ASC')
	end
	
end