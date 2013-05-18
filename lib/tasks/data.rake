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

		admin_galleries = Element.create(name: 'admin/galleries')
		admin_articles = Element.create(name: 'admin/articles')
		admin_categories = Element.create(name: 'admin/categories')
		admin_events = Element.create(name: 'admin/events')
		admin_images = Element.create(name: 'admin/images')
		admin_mercury_images = Element.create(name: 'admin/mercury_images')
		admin_pages = Element.create(name: 'admin/pages')
		admin_paintings = Element.create(name: 'admin/paintings')
		admin_slideshows = Element.create(name: 'admin/slideshows')
		admin_users = Element.create(name: 'admin/users')
		group_admin_cantons = Element.create(name: 'group/admin/cantons')
		group_admin_groups = Element.create(name: 'group/admin/groups')

		Ownership.create(element_id: admin_galleries.id, user_id: user.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_articles.id, user_id: user.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_categories.id, user_id: user.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_events.id, user_id: user.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_images.id, user_id: user.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_mercury_images.id, user_id: user.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_pages.id, user_id: user.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_paintings.id, user_id: user.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_slideshows.id, user_id: user.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_users.id, user_id: user.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: group_admin_cantons.id, user_id: user.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: group_admin_groups.id, user_id: user.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
	end
end