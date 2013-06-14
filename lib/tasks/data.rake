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

	desc "Add the user types"
	task usertypes: :environment do
		UserType.create(name: 'user')
		#userType.create(name: 'twitter')
		UserType.create(name: 'gplus')
		UserType.create(name: 'facebook')
		UserType.create(name: 'github')
		UserType.create(name: 'group')
	end

	desc "Add the admin user and ownerships"
	task admin: :environment do
		# Create groups
		g_admin = User.create(name: 'g_admin', user_type_id: UserType.find_by_name('group').id)
		g_user = User.create(name: 'g_user', user_type_id: UserType.find_by_name('group').id)
		g_base = User.create(name: 'g_base', user_type_id: UserType.find_by_name('group').id)
		g_ext = User.create(name: 'g_ext', user_type_id: UserType.find_by_name('group').id)

		# Create admin
		admin = User.create(email: 'kocher.ke@gmail.com', name: 'Admin', password: '12341', password_confirmation: '12341', user_type_id: UserType.find_by_name('user').id)
		
		# Add admin to groups
		Parent.create(user_id: admin.id, parent_id: g_admin.id)
		Parent.create(user_id: admin.id, parent_id: g_user.id)
		Parent.create(user_id: admin.id, parent_id: g_base.id)

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
		admin_ownerships = Element.create(name: 'admin/ownerships')
		group_admin_cantons = Element.create(name: 'group/admin/cantons')
		group_admin_groups = Element.create(name: 'group/admin/groups')
		comments = Element.create(name: 'comments')

		# ownerships for admin group :
		Ownership.create(element_id: admin_galleries.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_articles.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_categories.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_events.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_images.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_mercury_images.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_pages.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_paintings.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_slideshows.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_users.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: group_admin_cantons.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: group_admin_groups.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: comments.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_ownerships.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
	
		# ownership for base group :
		Ownership.create(element_id: comments.id, user_id: g_base.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
	end
end