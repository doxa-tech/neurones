namespace :db do

  desc "Update group's URL"
	task update_urls: :environment do
		Group.all.each do |group|
			group.url = SecureRandom.uuid
			group.save
		end
	end

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
