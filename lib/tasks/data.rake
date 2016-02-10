namespace :db do
	desc "Add the pages"
	task pages: :environment do
    %w[home presentation contact].each do |page|
			Page.create(name: page, title: "title", content: "content") if Page.find_by_name(page).nil?
		end
	end

	desc "Add the events type"
	task types: :environment do
		EventsType.find_or_create_by(name: 'neuroday')
	end

	desc "Add the cantons"
	task cantons: :environment do
    %w[Fribourg Vaud Valais Genève Jura Neuchâtel Berne].each do |canton|
	    Canton.create(name: canton)
    end
	end

	desc "Add the admin user and ownerships"
	task admin: :environment do

		# Base group
    base = Adeia::Group.find_or_create_by!(name: 'base')
    Adeia::Permission.find_or_add_by!(element: "comments", owner: base, type: "on_ownerships", read: true, create: true, update: true, destroy: false)

		# Create admin
    if User.find_by_email('kocher.ke@gmail.com').nil?
	    User.create!(email: 'kocher.ke@gmail.com', name: 'Admin', password: '12341', password_confirmation: '12341')
    end
	end

	desc "Update group's url"
	task update_urls: :environment do
		Group.all.each do |group|
			group.url = SecureRandom.uuid
			group.save
		end
	end

	desc "Add the modules"
	task modules: :environment do
	  group = G::ModuleType.find_or_create_by(name: "group")
	  g_module = G::ModuleType.find_or_create_by(name: "module")

	  news = group.modules.find_or_create_by(name: "news")
	  events = group.modules.find_or_create_by(name: "events")
	  galleries = group.modules.find_or_create_by(name: "galleries")

	  news.modules.find_or_create_by(name: "index_news", module_type_id: g_module.id)
	  news.modules.find_or_create_by(name: "last_news", module_type_id: g_module.id)

	  events.modules.find_or_create_by(name: "index_events", module_type_id: g_module.id)
	  events.modules.find_or_create_by(name: "last_events", module_type_id: g_module.id)

	  galleries.modules.find_or_create_by(name: "index_galleries", module_type_id: g_module.id)
	  galleries.modules.find_or_create_by(name: "last_galleries", module_type_id: g_module.id)
	end

	# create default group style
	desc "Create default group style"
	task style: :environment do
    scss = File.open("#{Rails.root}/lib/tasks/default.scss").read
		@style = G::Style.find_or_create_by(name: "default")
    @style.content = scss
		@style.theme = true
		@style.image = 'http://s22.postimg.org/443g9wee9/Capture_d_cran_2013_09_11_14_00_42.png'
		@style.save
	end

end
