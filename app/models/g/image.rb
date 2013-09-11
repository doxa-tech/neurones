class G::Image < ActiveRecord::Base
  belongs_to :group
  attr_accessible :image, :name

  mount_uploader :image, GImageUploader

  validates :image, presence: true

  before_create :default_name

  def default_name
  	self.name ||= File.basename(image.filename, '.*') if image
  end
end
