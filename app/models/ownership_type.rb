class OwnershipType < ActiveRecord::Base
  attr_accessible :name

  has_many :ownerships
end