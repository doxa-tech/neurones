class Gallery < ActiveRecord::Base
  attr_accessible :date, :description, :name

  has_many :paintings, :dependent => :destroy 

  validates :name, presence: true, length: { maximum: 55 }
  validates :description, presence: true
  validates :date, presence: true
end
