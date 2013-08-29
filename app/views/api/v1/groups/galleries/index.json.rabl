object @galleries
attributes *G::Gallery.column_names

node(:provider) { 'http://store.cloud.google.com' }
node(:edit_url) { 'my_url' }

child :paintings do
	attributes :id, :name
	child image: 'image' do
		attributes :url, :size, :blank?
	end
end