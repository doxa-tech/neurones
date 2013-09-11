object @galleries
attributes *G::Gallery.column_names

node(:provider) { 'http://store.cloud.google.com' }
node(:edit_url) { |gallery| edit_admin_gallery_url(gallery) }

child :paintings do
	attributes :id, :name
	child image: 'image' do
		attributes :url, :size, :blank?
	end
end