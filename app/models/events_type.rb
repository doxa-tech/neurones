class EventsType < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true, length: { maximum: 55 }, uniqueness: true

  has_many :events
end
