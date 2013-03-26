class Article < ActiveRecord::Base
  attr_accessible :content, :title

  validates :title, presence: true, length: { maximum: 55 }
  validates :content, presence: true
end
