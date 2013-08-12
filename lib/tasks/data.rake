namespace :db do 
	desc "Add the pages"
	task pages: :environment do
		Page.destroy_all
		
		Page.create(name: 'home', title: 'title', content: 'content')
		Page.create(name: 'presentation', title: 'title', content: 'content')
		Page.create(name: 'contact', title: 'title', content: 'content')
	end

	desc "Add the events type"
	task types: :environment do
		EventsType.destroy_all

		EventsType.create(name: 'neuroday')
	end

	desc "Add the cantons"
	task cantons: :environment do
		Group::Canton.destroy_all

		Group::Canton.create(name: 'Fribourg')
	end

	desc "Add the user types"
	task usertypes: :environment do
		UserType.destroy_all

		UserType.create(name: 'user')
		#userType.create(name: 'twitter')
		UserType.create(name: 'gplus')
		UserType.create(name: 'facebook')
		UserType.create(name: 'github')
		UserType.create(name: 'group')
	end

	desc "Add the admin user and ownerships"
	task admin: :environment do
		# Reset DB
		User.destroy_all
		Parent.destroy_all
		OwnershipType.destroy_all
		Ownership.destroy_all
		Element.destroy_all


		# Create groups
		user_type_group = UserType.find_by_name('group')
		g_admin = user_type_group.users.create(name: 'g_admin')
		g_user = user_type_group.users.create(name: 'g_user')
		g_base = user_type_group.users.create(name: 'g_base')
		g_ext = user_type_group.users.create(name: 'g_ext')

		# Create admin
		user_type_user = UserType.find_by_name('user')
		admin = user_type_user.users.create(email: 'kocher.ke@gmail.com', name: 'Admin', password: '12341', password_confirmation: '12341')
		
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
		admin_pages = Element.create(name: 'admin/pages')
		admin_paintings = Element.create(name: 'admin/paintings')
		admin_slideshows = Element.create(name: 'admin/slideshows')
		admin_users = Element.create(name: 'admin/users')
		admin_ownerships = Element.create(name: 'admin/ownerships')
		admin_parents = Element.create(name: 'admin/parents')
		admin_cantons = Element.create(name: 'admin/cantons')
		group_admin_groups = Element.create(name: 'admin/group/groups')
		comments = Element.create(name: 'comments')
		
		# ownerships for admin group :
		Ownership.create(element_id: admin_galleries.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_articles.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_categories.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_events.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_images.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_pages.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_paintings.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_slideshows.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_users.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: group_admin_cantons.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: group_admin_groups.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: comments.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_ownerships.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
		Ownership.create(element_id: admin_parents.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)

		# ownership for base group :
		Ownership.create(element_id: comments.id, user_id: g_base.id, ownership_type_id: type3.id, right_read: true, right_create: true, right_update: true, right_delete: false)
	end
	
	# update done in the admin tasks
	desc "Modify elements"
	task modify_elements: :environment do
	  group_admin_groups = Element.find_by_name('group/admin/groups')
	  group_admin_groups.name = 'admin/group/groups'
	  group_admin_groups.save
	  group_admin_cantons = Element.find_by_name('group/admin/cantons')
	  group_admin_cantons.name = 'admin/cantons'
	  group_admin_cantons.save
	  element = Element.find_by_name('admin/mercury_images')
	  element.destroy
	end
	
	desc "Add the modules"
	task modules: :environment do
	  Group::Module.destroy_all
	  Group::Module.create(name: "news")
	  Group::Module.create(name: "events")
	  Group::Module.create(name: "galleries")
	  Group::Module.create(name: "texts")
	end
end