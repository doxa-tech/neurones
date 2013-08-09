class Canton < ActiveRecord::Base
  attr_accessible :name

  has_many :groups, class_name: Group::Group

  validates :name, presence: true, length: { maximum: 55 }
end
