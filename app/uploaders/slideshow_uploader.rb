# encoding: utf-8

class SlideshowUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include CarrierWave::Processing::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fill => [984, 154]
  process :quality => 90

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
