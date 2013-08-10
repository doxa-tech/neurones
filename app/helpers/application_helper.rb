module ApplicationHelper

	def store_location
		session[:return_to] = request.fullpath
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	# Renvoi l'image gravar de l'utilisateur courant ou d'un utilisateur passé en argument. 
	# On test premièrement si l'utilisateur existe
	# et ensuite si son champs gravatar_email n'est pas nil.
	# 
	# * *Args*		:
	#   - l'utilisateur
	#   - la taille de l'avatar (default 100)
	# * *Returns*	:
	#   - l'image gravatar de l'utilisateur
	#   - ou un message d'erreur s'il n'y a pas d'utilisateur
	#
	def gravatar(user, size = 100)
		default_url = URI.escape "#{root_url}assets/user/avatar.jpg"
		if user.gravatar_email
			image_tag "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(user.gravatar_email.downcase)}.png?d=#{default_url}&s=#{size}"
		else
			image_tag "http://gravatar.com/avatar/#{Digest::MD5.hexdigest('no')}.png?d=#{default_url}&s=#{size}"
		end
	end

  # Test si un utilisateur possède un avatar valide
  # Envoie la requête à gravatar et analyse si le retour est une erreur 404
	# 
	# * *Args*		:
	#   - l'utilisateur
	# * *Returns*	:
	#   - true ou false
	#
	def gravatar?(user)
		if user.gravatar_email && Rails.env.production?
			gravatar_check = "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(user.gravatar_email.downcase)}.png?d=404"
			uri = URI.parse(gravatar_check)
			http = Net::HTTP.new(uri.host, uri.port)
			request = Net::HTTP::Get.new(uri.request_uri)
			response = http.request(request)
			if (response.code.to_i == 404)
				return false
			else
				return true
			end 
		else
			return false 
		end
	end
	
end
