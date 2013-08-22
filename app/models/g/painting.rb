class G::Painting < ActiveRecord::Base
  belongs_to :gallery
  attr_accessible :image, :name, :gallery_id

  mount_uploader :image, PaintingUploader

  before_create :default_name

  def default_name
  	self.name ||= File.basename(image.filename, '.*') if image
  end
end
