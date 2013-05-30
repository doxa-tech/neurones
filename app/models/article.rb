class Article < ActiveRecord::Base
  attr_accessible :content, :title, :subtitle, :likes, :category_id, :image, :slug

  belongs_to :user
  belongs_to :category
  has_many :comments, :dependent => :destroy 

  validates :title, presence: true, length: { maximum: 55 }
  validates :content, presence: true
  validates :subtitle, presence: true
  validates :category_id, presence: true
  validates :user_id, presence: true

  before_validation :generate_slug
	
	def to_param
  	slug 
	end

	def generate_slug
  	self.slug ||= title.parameterize
	end
end
