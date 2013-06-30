class MercuryImage < ActiveRecord::Base
  attr_accessible :image

  mount_uploader :image, MercuryUploader

  has_many :articles

  validates :image, presence: true
end
