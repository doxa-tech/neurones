class Article < ActiveRecord::Base
  attr_accessible :content, :title, :subtitle, :likes, :category_id, :mercury_image_id

  belongs_to :mercury_image
  belongs_to :user
  belongs_to :category
  has_many :comments, :dependent => :destroy 

  validates :title, presence: true, length: { maximum: 55 }
  validates :content, presence: true
  validates :subtitle, presence: true, length: { maximum: 55 }
  validates :category_id, presence: true
  validates :user_id, presence: true
	
	def to_param
  	"#{id}-#{title}".parameterize
	end
end
