class MercuryImage < ActiveRecord::Base
  attr_accessible :image

  mount_uploader :image, MercuryUploader

  validates :image, presence: true
end
