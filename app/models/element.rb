class Element < ActiveRecord::Base
  attr_accessible :name

  has_many :ownerships, :dependent => :destroy

  validates :name, presence: true, uniqueness: true
end
