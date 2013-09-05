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
		admin_groups = Element.create(name: 'admin/groups')
		comments = Element.create(name: 'comments')
		admin_modules = Element.create(name: 'admin/modules')
		admin_styles = Element.create(name: 'admin/styles')
		
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
		Ownership.create(element_id: admin_modules.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
	  Ownership.create(element_id: admin_styles.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)

		# ownership for base group :
		Ownership.create(element_id: comments.id, user_id: g_base.id, ownership_type_id: type3.id, right_read: true, right_create: true, right_update: true, right_delete: false)
	end
	
	# update done in the admin tasks
	desc "Modify elements"
	task modify_elements: :environment do
	  group_admin_groups = Element.find_by_name('group/admin/groups')
	  group_admin_groups.name = 'admin/groups'
	  group_admin_groups.save
	  group_admin_cantons = Element.find_by_name('group/admin/cantons')
	  group_admin_cantons.name = 'admin/cantons'
	  group_admin_cantons.save
	  element = Element.find_by_name('admin/mercury_images')
	  element.destroy
	  g_admin = User.find_by_name('g_admin')
	  type2 = OwnershipType.find_by_name('all_entries')
	  admin_modules = Element.create(name: 'admin/modules')
	  admin_styles = Element.create(name: 'admin/styles')
	  Ownership.create(element_id: admin_modules.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
	  Ownership.create(element_id: admin_styles.id, user_id: g_admin.id, ownership_type_id: type2.id, right_read: true, right_create: true, right_update: true, right_delete: true)
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
	  G::Module.destroy_all
	  G::ModuleType.destroy_all
	  group = G::ModuleType.create(name: "group")
	  g_module = G::ModuleType.create(name: "module")

	  news = group.modules.create(name: "news")
	  events = group.modules.create(name: "events")
	  galleries = group.modules.create(name: "galleries")

	  news.modules.create(name: "index_news", module_type_id: g_module.id)
	  news.modules.create(name: "last_news", module_type_id: g_module.id)

	  events.modules.create(name: "index_events", module_type_id: g_module.id)
	  events.modules.create(name: "last_events", module_type_id: g_module.id)

	  galleries.modules.create(name: "index_galleries", module_type_id: g_module.id)
	  galleries.modules.create(name: "last_galleries", module_type_id: g_module.id)
	end

	# create default group style
	desc "Create default group style"
	task style: :environment do
		G::Style.create(name: "default", content: "
			@charset 'utf-8';
			/* CSS Document */

			@import 'variables.css.scss';

			html {
				/* needed for background and footer */
				min-height: 100%;
				position: relative;
			}
				
			body {
				/* needed for background and footer */
				height: 100%;
				//margin-bottom: 50px;
			}

			html body #group_container {

				width: 980px;
				margin: auto;
				padding: 0 20px 30px 20px;
				min-height: 100%; /* footer needs */
				margin-bottom: 70px; /* footer needs */
				font-family: Ubuntu, Tahoma, Geneva, sans-serif;
				line-height: 1.3em;
				color: #777;
				background: #fff;
				border-bottom-left-radius: 20px;border-bottom-right-radius: 20px; 
				font-size: 14px; 

				a {
					text-decoration: none;
					color: $color_link;
					font-weight: bold;
				}

				a:hover{ 
					text-decoration: underline;
				}

				h1 {
					text-align: center;
					font-size: 2.7em;
					margin: 40px 0 20px 0;
					color: $color_title;
					font-weight: bold;
					text-shadow: 0 1px 0 #ccc, 
			               0 2px 0 #c9c9c9,
			               0 3px 0 #bbb,
			               0 4px 0 #b9b9b9,
			               0 5px 0 #aaa,
			               0 6px 1px rgba(0,0,0,.1),
			               0 0 5px rgba(0,0,0,.1),
			               0 1px 3px rgba(0,0,0,.3),
			               0 3px 5px rgba(0,0,0,.2),
			               0 5px 10px rgba(0,0,0,.2),
			               0 10px 10px rgba(0,0,0,.1),
			               0 20px 20px rgba(0,0,0,.05);
				}

				h2 {
					font-size: 1.3em;
					text-align: center;
					margin: 10px 0 10px 0; padding: 10px;
					color: $color_h3;
					border-bottom: 1px solid #eee;
				}

				p {margin: 0 0 7px 0}

				.banner {
					width: 1020px; height: 200px;
					background: url('/assets/group/theme/default/banner.jpg') no-repeat;
					position: relative; left: -20px; // -20px for container padding
				}

				.background {
					z-index: -9999;
					position: absolute; top: 0; left: 0; bottom: 0; right: 0;
					background: #000 url('/assets/group/theme/default/bg.jpg') no-repeat;
					background-position: center top;
				}

				// News module

				.module_news {
					background: #757ba3;
					padding: 20px 20px 1px 20px;
					color: #ccd3ff;

					.new {
						margin: 0 0 30px 0;
					}

					h3 {
						font-size: 1.2em;
						color: #000;
						margin: 0 0 15px 0;
						sup {
							font-size: 9px;
						}
					}

				}

				// Events module

				.module_events_last {
					//background: #ffd188;
					padding: 20px 20px 1px 20px;
					color: #000;

					.event {
						margin: 0 0 30px 0;
					}

					h3 {
						font-size: 1.2em;
						color: #000;
						margin: 0 0 0 0;
						i {
							color: #ff9c00;
						}
					}

					.date {
						margin: 0 0 20px 0;
						font-size: 1.1em;
						font-weight: bold;
						color: #777;
					}

				}

				.module_events_index {
					width: 980px;
					color: #000;

					.title {
						font-size: 18px;
						margin: 0 0 20px 0;
						.left{
							display: inline-block;
							width: 488px;
						}
						.right{
							display: inline-block;
							width: 488px;
							text-align: right;
						}
						i {font-size: 14px; font-style: normal}
					}

					table#timeline {
						width: 90%;
						margin: auto;
						border-collapse:separate;
						border-spacing: 2px;
						font-size: .8em;

							.marker td {
								font-size: 1.5em;
								padding: 5px;
								text-align: center;
							}

							.date td {
								background: #e9a7a7;
								padding: 5px;
								text-align: center;
								font-size: 1.2em;
								font-weight: 100;
							}

							.date td.weekend {
								background: #a7b8e9;
								color: #fff;
							}

							i {font-size: 1.5em}
							a:hover {text-decoration:none}

					}

					p.subtitle {
						text-align: center;
						font-size: 1.3em;
						padding: 30px 0;
					}

					table#summary_timeline {
						width: 90%;
						margin: auto;
						border-collapse:separate;
						border-spacing: 1px;

						td.countdown {
							width: 100px;
							font-size: .9em;
							position: relative;
							span.anchor {position:absolute;top:-30px;}
						}

						td.marker {
							font-size: 1.5em;
							width: 60px;
							text-align: center;
						}

						td.number {
							background: #e9a7a7;
							text-align: center;
							color: #fff;
							width: 30px;
						}

						td.weekend {
							background: #a7b8e9;
							text-align: center;
							padding: 0 5px;
						}

						td.description {
							padding: 0 0 30px 20px;
							div.toggle_wrap, div.toggle_now {display:none}
							a:hover {text-decoration:none;cursor:pointer}
						}

					}

				}

			}

			")
	end

end