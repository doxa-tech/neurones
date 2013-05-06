class Article < ActiveRecord::Base
  attr_accessible :content, :title, :subtitle, :author, :likes, :category

  validates :title, presence: true, length: { maximum: 55 }
  validates :content, presence: true
  validates :subtitle, presence: true
  validates :category, presence: true
  validates :author, presence: true
end
