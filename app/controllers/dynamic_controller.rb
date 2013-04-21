class DynamicController < ApplicationController

	def plus
		
	end

	def login
		@path = request.env['PATH_INFO']
	end

end
