#!/bin/env ruby
# encoding: utf-8

module SessionsHelper

	def sign_in(user)
		cookies[:remember_token] = user.remember_token
		self.current_user = user
	end

	def sign_in_permanent(user)
		cookies[:remember_token] = { value: user.remember_token, expires: Time.now + 2592000 }
		self.current_user = user
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end

	def current_user?(user)
		user == current_user
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def index_right(element)
		if @ownerships_all.any?
			@elements = element.page(params[:page]).per_page(10)
		elsif @ownerships_on_ownership.any?
			@elements = element.where('user_id = ?', current_user.id).page(params[:page]).per_page(10)
		elsif @ownerships_on_entry.any?
			@ownerships_on_entry.each do |entry|
				@elements += element.find(entry.id)
			end
			@elements.page(params[:page]).per_page(10)
		else
			redirect_to(root_path, notice: "Vous n'avez pas les droits nécessaires pour afficher les éléments.")
		end
	end

	def update_right(element)
		if @ownerships_all.any?
			@element = element.find(params[:id])
		elsif @ownerships_on_ownership.any?
			@element = element.where('user_id = ? AND id = ?', current_user.id, params[:id]).first
		elsif @ownerships_on_entry.any?
			@ownerships_on_entry.each do |entry|
				if entry.id == params[:id]
					@element = element.find(entry.id)
				end
			end
		redirect_to(root_path, notice: "Vous n'avez pas les droits nécessaires pour éditer l'élément.") if @element.nil
		end
	end
end
