# This is the kind of json response that is required by jQuery-File-Upload
# The required bits are buried somewhere in the jquery-file-download scripts
json.array!([@painting]) do |painting|
  json.name            	painting.image
  json.size            	painting.image.size
  json.current_path  		painting.image.current_path
  json.url           		painting.image.url
  json.thumbnail_url   	painting.image.url(:thumb)
end
