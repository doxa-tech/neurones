class Level < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many :users, :inverse_of => :level
end
