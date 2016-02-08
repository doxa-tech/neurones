class Comment < ActiveRecord::Base
  attr_accessible :content, :thumbdown, :thumbup, :title, :article_id, :comment_id

  validates :title, presence: true, length: { maximum: 55 }
  validates :content, presence: true

  belongs_to :user
  belongs_to :article
  belongs_to :comment
  has_many :comments, :dependent => :destroy

  def balanced_vote
    if (balance = thumbup - thumbdown) >= 0
      "+ #{balance}"
    else
      " #{balance}"
    end
  end
end
