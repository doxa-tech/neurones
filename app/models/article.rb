class Article < ActiveRecord::Base
  include ActionView::Helpers::SanitizeHelper
  attr_accessible :content, :title, :subtitle, :likes, :category_id, :image_attributes

  belongs_to :image
  belongs_to :user
  belongs_to :category
  has_many :comments, :dependent => :destroy 

  validates :title, presence: true, length: { maximum: 55 }
  validates :content, presence: true
  validates :subtitle, presence: true, length: { maximum: 55 }
  validates :category_id, presence: true
  validates :user_id, presence: true

  accepts_nested_attributes_for :image

  before_save :format_title

	def to_param
  	"#{id}-#{title}".parameterize
	end

  private

  def format_title
    self.title = strip_tags(self.title)
  end
end
