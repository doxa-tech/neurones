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

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end
end
