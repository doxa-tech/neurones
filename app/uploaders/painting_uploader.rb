# encoding: utf-8

class PaintingUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include CarrierWave::Processing::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.gallery_id}/#{model.id}"
  end

  process :resize_to_limit => [1200, 1200]
  process :quality => 90

  version :thumb do
    process resize_to_fit: [136, 90]
    process :quality => 90
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
