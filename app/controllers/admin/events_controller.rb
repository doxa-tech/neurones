#!/bin/env ruby
# encoding: utf-8

class Admin::EventsController < Admin::BaseController
	before_filter only: [:index] {|controller| controller.index_right(Event)}
	before_filter only: [:edit] {|controller| controller.edit_right(Event)}
	before_filter only: [:destroy, :update] {|controller| controller.modify_right(Event)}

	def index
		#see before_filter
	end

	def new 
		@element = Event.new
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
		#see before_filter
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

	def destroy
		Event.find(params[:id]).destroy
		flash[:success] = "Evénement supprimé"
		redirect_to admin_events_path
	end

end
