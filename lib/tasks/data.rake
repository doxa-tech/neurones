namespace :db do 
	desc "Add the pages"
	task pages: :environment do
		Page.create(name: 'home', title: 'title', content: 'content')
		Page.create(name: 'presentation', title: 'title', content: 'content')
		Page.create(name: 'contact', title: 'title', content: 'content')
	end

	desc "Add the events type"
	task types: :environment do
		EventsType.create(name: 'neuroday')
	end

	desc "Add the cantons"
	task cantons: :environment do
		Group::Canton.create(name: 'Fribourg')
	end

	desc "Add the admin user and ownerships"
	task admin: :environment do
		user = User.create(email: 'kocher.ke@gmail.com', name: 'Admin', password: '12341', password_confirmation: '12341')

		type1 = OwnershipType.create(name: 'on_entry')
		type2 = OwnershipType.create(name: 'all_entries')
		type3 = OwnershipType.create(name: 'on_ownership')

		admin_gallery = Element.create(name: 'admin/galleries')
		Ownership.create(element_id: admin_gallery.id, user_id: user.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
	end
end