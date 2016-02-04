#!/bin/env ruby
# encoding: utf-8

class Admin::G::EventsController < Admin::G::BaseController
	before_filter { |controller| controller.module_activated?('events')}

	def index
		@table = GEventTable.new(self, G::Event.where(group: current_group))
	  @table.respond
	end

	def new
		@event = current_group.events.new
	end

	def create
		@event = current_group.events.new(params[:g_event])
		if @event.save
			flash[:success] = "Evénement ajouté"
			redirect_to admin_group_g_events_path(current_group)
		else
			render 'new'
		end
	end

	def edit
		@event = G::Event.find(params[:id])
	end

	def update
		@event = G::Event.find(params[:id])
		if @event.update_attributes(params[:g_event])
			flash[:success] = "Evénement enregistrée"
			redirect_to admin_group_g_events_path(current_group)
		else
			render 'edit'
		end
	end

	def destroy
		G::Event.find(params[:id]).destroy
		flash[:success] = "Evénement supprimé"
		redirect_to admin_group_g_events_path(current_group)
	end

end
