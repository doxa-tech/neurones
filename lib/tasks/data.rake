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
		@style = G::Style.new(name: "default", content: "
  &{
  width:980px;
  margin: auto;
  padding: 0 20px 30px 20px;
  min-height: 100%; /* footer needs */
  margin-bottom: 70px; /* footer needs */
  font-family: Ubuntu, Tahoma, Geneva, sans-serif;
  line-height: 1.3em;
  color:#777;
  background:#ffffff;
  border-bottom-left-radius: 20px;border-bottom-right-radius: 20px; 
  font-size: 14px; }

a {
  text-decoration: none;
  color:#7f72f5;
  font-weight: bold; }

a:hover {
  text-decoration: underline; }

h1 {
  text-align:center;
  font-size: 2.7em;
  margin: 40px 0 20px 0;
  color:#656a8d;
  font-weight: bold;
  text-shadow: 0 1px 0 #cccccc, 0 2px 0 #c9c9c9, 0 3px 0 #bbbbbb, 0 4px 0 #b9b9b9, 0 5px 0 #aaaaaa, 0 6px 1px rgba(0, 0, 0, 0.1), 0 0 5px rgba(0, 0, 0, 0.1), 0 1px 3px rgba(0, 0, 0, 0.3), 0 3px 5px rgba(0, 0, 0, 0.2), 0 5px 10px rgba(0, 0, 0, 0.2), 0 10px 10px rgba(0, 0, 0, 0.1), 0 20px 20px rgba(0, 0, 0, 0.05); }

h2 {
  font-size: 1.3em;
  text-align: center;
  margin: 10px 0 10px 0;
  padding: 10px;
  color:#b87f00;
  border-bottom: 1px solid #eee; }

p {
  margin: 0 0 7px 0; }

.banner {
  width: 1020px;
  height: 200px;
  background-image:url(/assets/group/theme/default/banner.jpg);
  background-repeat:no-repeat;
  position: relative;
  left: -20px; }

.background {
  z-index: -9999;
  position: absolute;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  background-image:url(/assets/group/theme/default/bg.jpg);
  background-color:#000000;
  background-repeat:no-repeat;
  background-position:center top; }

header {
  width: 1020px;
  background: #222;
  position: relative; top: 0px; left: -20px; // -20px for container padding
  box-shadow: 0px 2px 10px #777;
}

  header nav {
    width: 980px;
    margin: auto;
    height: 33px; }

  header img.motif {
    position: absolute;
    left: 0;
    top: 0;
    height: 120px; }

  header nav ul {
    text-align: center; }

  header nav ul li {
    display: inline; /* Instead of insane float: left */
    list-style: none;
    position: relative; /* For submenu */ }

  header nav ul li a {
    text-decoration: none;
    font-size: .9em;
    font-weight: 100;
    display: inline-block;
    width: 5em;
    text-align: center;
    padding: .5em .2em;
    border-radius: 1px;
    color:#ffffff;
    background:#737aa1;
    min-width: 90px;
    height: 20px; }

  header nav ul li a:hover,header nav ul li a.selected{
    background:#bec7ff;
    color:#fff;
    text-decoration: none; }

  header nav ul li ul {
    position: absolute;
    left: 0;
    display: none;
    z-index: 3; }

  header nav ul li ul a {
    display: block; }

  header nav ul li.submenu a.not_link {
    cursor: default; }

    header nav ul li.submenu a {
      vertical-align: bottom; }

  header nav ul i {
    font-size: 12px; }

.module_news {
  background-color:#757ba3;
  padding: 20px 20px 1px 20px;
  color:#ccd3ff; }
  .module_news .new {
    margin: 0 0 30px 0; }
  .module_news h3 {
    font-size: 1.2em;
    text-align:left;
    color:#000;
    margin: 0 0 15px 0; }
    .module_news h3 sup {
      font-size: 9px; }

.module_events_last {
  padding: 20px 20px 1px 20px;
  color: #000; }
  .module_events_last .event {
    margin: 0 0 30px 0; }
  .module_events_last h3 {
    font-size: 1.2em;
    color: #000;
    margin: 0 0 0 0; }
    .module_events_last h3 i {
      color: #ff9c00; }
  .module_events_last .date {
    margin: 0 0 20px 0;
    font-size: 1.1em;
    font-weight: bold;
    color: #777; }

.module_events_index {
  width: 980px;
  color:#000; }
  .module_events_index .title {
    font-size: 18px;
    color:#000;
    margin: 0 0 20px 0; }
    .module_events_index .title .left {
      display: inline-block;
      width: 488px; }
    .module_events_index .title .right {
      display: inline-block;
      width: 488px;
      text-align: right; }
    .module_events_index .title i {
      font-size: 14px;
      font-style: normal; }
  .module_events_index table#timeline {
    width: 90%;
    margin: auto;
    border-collapse: separate;
    border-spacing: 2px;
    font-size: .8em; }
    .module_events_index table#timeline .marker td {
      font-size: 1.5em;
      padding: 5px;
      text-align: center; }
        .module_events_index table#timeline .marker td a {
          color:#00d644; }
    .module_events_index table#timeline .date td {
      background:#e9a7a7;
      color:#000;
      padding: 5px;
      text-align: center;
      font-size: 1.2em;
      font-weight: 100; }
    .module_events_index table#timeline .date td.weekend {
      background:#a7b8e9;
      color:#ffffff; }
    .module_events_index table#timeline i {
      font-size: 1.5em; }
    .module_events_index table#timeline a:hover {
      text-decoration: none; }
  .module_events_index p.subtitle {
    text-align: center;
    font-size: 1.3em;
    padding: 30px 0; }
  .module_events_index table#summary_timeline {
    width: 90%;
    margin: auto;
    border-collapse: separate;
    border-spacing: 1px; }
    .module_events_index table#summary_timeline td.countdown {
      width: 100px;
      font-size: .9em;
      color:#000;
      position: relative; }
      .module_events_index table#summary_timeline td.countdown span.anchor {
        position: absolute;
        top: -30px; }
    .module_events_index table#summary_timeline td.marker {
      font-size: 1.5em;
      width: 60px;
      color:#00d644;
      text-align: center; }
    .module_events_index table#summary_timeline td.number {
      background:#e9a7a7;
      text-align: center;
      color:#fff;
      width: 10px; }
    .module_events_index table#summary_timeline td.weekend {
      background:#a7b8e9;
      color:#000;
      width: 10px;
      text-align: center;
      padding: 0 5px; }
    .module_events_index table#summary_timeline td.description {
      color:#000000;
      padding: 0 0 30px 20px; }
      .module_events_index table#summary_timeline td.description .description_title a {
        color:#00d644;}
      .module_events_index table#summary_timeline td.description div.toggle_wrap, .module_events_index table#summary_timeline td.description div.toggle_now {
        display: none; }
      .module_events_index table#summary_timeline td.description a:hover {
        text-decoration:underline;
        cursor: pointer; }
			")
		@style.theme = true
		@style.image = 'http://s22.postimg.org/443g9wee9/Capture_d_cran_2013_09_11_14_00_42.png'
		@style.save
	end

end