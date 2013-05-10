class Article < ActiveRecord::Base
  attr_accessible :content, :title, :subtitle, :user_id, :likes, :category_id

  belongs_to :user
  belongs_to :category
  has_many :comments


end
