class Gallery < ActiveRecord::Base
  attr_accessible :date, :description, :name, :slug

  has_many :paintings, :dependent => :destroy 

  validates :name, presence: true, length: { maximum: 55 }, uniqueness: true
  validates :description, presence: true
  validates :date, presence: true

  before_validation :generate_slug
	
	def to_param
  	slug 
	end

	def generate_slug
  	self.slug ||= name.parameterize
	end
end
