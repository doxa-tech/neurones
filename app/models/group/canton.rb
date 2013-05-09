class Group::Canton < ActiveRecord::Base
  attr_accessible :name

  has_many :groups

  validates :name, presence: true, length: { maximum: 55 }
end
