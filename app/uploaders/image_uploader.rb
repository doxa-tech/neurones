# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include CarrierWave::Processing::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_limit => [900, 200]
  process :quality => 90

    version :blog do
      process resize_to_limit: [400, 600]
      process :quality => 90
    end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
