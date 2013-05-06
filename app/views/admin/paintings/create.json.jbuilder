# This is the kind of json response that is required by jQuery-File-Upload
# The required bits are buried somewhere in the jquery-file-download scripts
json.array!([@painting]) do |json, photo|
  json.name            	photo.image
  json.size            	photo.image.size
  json.current_path  		photo.image.current_path
  json.url           		photo.image.url
  json.thumbnail_url   	photo.image.url(:thumb)
end