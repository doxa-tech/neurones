class Comment < ActiveRecord::Base
  attr_accessible :content, :thumbdown, :thumbup, :title, :user_id, :article_id, :comment_id

  validates :title, presence: true, length: { maximum: 55 }
  validates :content, presence: true

  belongs_to :user
  belongs_to :article
  belongs_to :comment
  has_many :comments
end
