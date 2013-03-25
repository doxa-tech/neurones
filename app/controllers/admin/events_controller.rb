#!/bin/env ruby
# encoding: utf-8

class Admin::EventsController < Admin::BaseController

	def index
		@events = Event.page(params[:page]).order('date DESC').per_page(10)
	end

	def new 
		@event = Event.new
	end

	def create
		@event = Event.new(params[:event])
		if @event.save
			flash[:success] = "Evénement ajouté"
			redirect_to admin_events_path
		else
			render 'new'
		end
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
		if @event.update_attributes(params[:event])
			flash[:success] = "Evénement enregistrée"
			redirect_to admin_events_path
		else
			render 'edit'
		end
	end

end
