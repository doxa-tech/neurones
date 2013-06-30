class MercuryImage < ActiveRecord::Base
  attr_accessible :image

  mount_uploader :image, MercuryUploader

  belongs_to :article

  validates :image, presence: true
end
