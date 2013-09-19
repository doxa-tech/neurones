class Comment < ActiveRecord::Base
  attr_accessible :content, :thumbdown, :thumbup, :title, :article_id, :comment_id

  validates :title, presence: true, length: { maximum: 55 }
  validates :content, presence: true

  belongs_to :user
  belongs_to :article
  belongs_to :comment
  has_many :comments, :dependent => :destroy 

  include PgSearch
  pg_search_scope :search, against: self.column_names,
  using: {tsearch: {dictionary: "french"}},
  associated_against: {article: :title, comment: :title, user: :name}
end
