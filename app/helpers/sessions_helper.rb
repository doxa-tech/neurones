#!/bin/env ruby
# encoding: utf-8

module SessionsHelper

	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
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

	def signed_in_user
		unless !current_user.nil? && current_user.level_id == 1
			redirect_to connexion_path, notice: "Connectez-vous pour accèder a cette page."
		end
	end

	def signed_in_admin
		unless !current_user.nil? && current_user.level_id >= 2
			redirect_to connexion_path, notice: "Vous n'avez pas l'autorisation d'accèder à cette page."
		end
	end

	def signed_in_superadmin
		unless !current_user.nil? && current_user.level_id >= 3
			redirect_to connexion_path, notice: "Vous n'avez pas l'autorisation d'accèder à cette page."
		end
	end

	def signed_in_user?
		if !current_user.nil?
			current_user.level_id >= 1
		end
	end

	def signed_in_superadmin?
		if !current_user.nil?
			current_user.level_id >= 3
		end
	end
end
