class Page < ActiveRecord::Base
  attr_accessible :content, :name, :title

  validates :content, presence: true
  validates :name, presence: true, length: { maximum: 55 }, uniqueness: true
  validates :title, presence: true, length: { maximum: 55 }
end
