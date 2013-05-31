class Gallery < ActiveRecord::Base
  attr_accessible :date, :description, :name

  has_many :paintings, :dependent => :destroy 

  validates :name, presence: true, length: { maximum: 55 }, uniqueness: true
  validates :description, presence: true
  validates :date, presence: true
	
	def to_param
  	"#{id}-#{name}".parameterize
	end
end
