class OwnershipType < ActiveRecord::Base
  attr_accessible :name

  has_many :ownerships

  validates :name, presence: true, uniqueness: true
end
