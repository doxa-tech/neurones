# encoding: utf-8

class ArticlesUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include CarrierWave::Processing::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_limit: [400, 600]
  process :quality => 90

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
