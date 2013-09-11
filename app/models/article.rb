class Article < ActiveRecord::Base
  include ActionView::Helpers::SanitizeHelper
  attr_accessible :content, :title, :subtitle, :likes, :category_id, :image

  belongs_to :user
  belongs_to :category
  has_many :comments, :dependent => :destroy 

  validates :title, presence: true, length: { maximum: 120 }
  validates :content, presence: true
  validates :subtitle, presence: true, length: { maximum: 120 }
  validates :category_id, presence: true
  validates :user_id, presence: true

  mount_uploader :image, ArticlesUploader

  before_save :format_title

  include PgSearch
  pg_search_scope :search, against: self.column_names,
  using: {tsearch: {dictionary: "french"}},
  associated_against: {user: :name, category: :name}

	def to_param
  	"#{id}-#{title}".parameterize
	end

  private

  def format_title
    self.title = strip_tags(self.title)
  end
end
