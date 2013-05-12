class Element < ActiveRecord::Base
  attr_accessible :name

  has_one :page
  has_many :ownerships
end
