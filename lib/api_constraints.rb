class ApiConstraints
	def initialize(options)
		@version = options[:version]
		@default = options[:default]
	end

	def matches?(req)
		@default || req.headers['Accept'].include?("application/vnd.example.v#{@version}")
	end
end

#to specify, need in header :
#  Accept : application/vnd.example.v1