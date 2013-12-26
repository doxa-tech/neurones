attributes *G::Gallery.column_names

node(:edit_url) { |gallery| edit_admin_group_g_gallery_url(Group.find(params[:group_id]),gallery) }

child :paintings do
	attributes :id, :name
	child image: 'image' do
		attributes :url, :size, :blank?
	end
end
