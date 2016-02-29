module ApplicationHelper

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
		if user.gravatar_email && gravatar?(user)
			image_tag "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(user.gravatar_email.downcase)}.png?s=#{size}"
		else
			image_tag "user/avatar.jpg"
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

  def link_to_active(label, path)
    css_class = "selected" if current_page?(path)
    link_to label, path, class: css_class
  end

  def has_active_page?(*args)
    args.each { |path| return "selected" if current_page?(path) }
  end

end
