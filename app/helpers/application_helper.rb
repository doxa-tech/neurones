module ApplicationHelper

	# Store the current url in session's variable
	#
	# * *Args*		:
	#
	# * *Returns*	:
	#
	def store_location
		session[:return_to] = request.fullpath
	end

	# Redirect the user to the stored url or the default one provided
	#
	# * *Args*		:
	# 	- default path to redirect to
	# * *Returns*	:
	#
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

	# Display a canton given a uniq id with all groups in that canton
	#
	# * *Args*		:
	#   - canton id
	# * *Returns*	:
	#   - the groups inside the canton
	#
	# pour l'id du li on est obligé d'ajouter un truc avant sinon sa fait concurence sur la page du catalogue
	def display_canton(canton_id)
		@groups.each do |group|
			if group.canton.id == canton_id
				concat "<li id='gr#{group.id}'>".html_safe
				concat "<h3 class='a_group'><a href='#{group.website.empty? ? nil : group.website}' target='_blank'>#{group.name}</a>".html_safe + ' - ' + group.city + '</h3>'.html_safe
				concat truncate(group.description, length: 100, separator: ' ')
				concat (' <a class="plus" href="' + catalogue_path + '#' + group.id.to_s + '">(afficher plus)</a>').html_safe
				concat '</li>'.html_safe
			end
		end
	end

	# Display groups given the canton id
	#
	# * *Args*		:
	#   - canton id
	# * *Returns*	:
	#   - the groups
	#
	def display_groups(canton_id)
		@groups.each do |group|
			if group.canton.id == canton_id
				concat ('<div class="group" id="' + group.id.to_s + '">').html_safe
				concat ('<h3>'.html_safe  + group.name + ' <span style="font-size:.7em;font-style:italic"> à '.html_safe + group.city + '</span></h3>'.html_safe)
				if group.website_activated
					concat image_tag image_url group.style.content.scan(/background-image:(.*?);/)[0][0][4..-2].strip
				else
					concat image_tag image_url 'group/index/default.jpg'
				end
				#concat ('<p>'.html_safe  + group.description + '</p>'.html_safe)
				concat ('<p>'.html_safe  + link_to(group.website, group.website) + '</p>'.html_safe) unless group.website.empty?
				concat ('<p>'.html_safe  + link_to('Page perso', group.url) + '</p>'.html_safe) if group.website_activated
				concat ('</div>').html_safe
			end
		end
	end

end
