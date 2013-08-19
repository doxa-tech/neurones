class G::Page < ActiveRecord::Base
  has_many :comp_pages, :dependent => :destroy 
  has_many :comp_groups, through: :comp_pages
  belongs_to :group
  attr_accessible :name, :page_order, :url
  
  validates :name, presence: true, length: { maximum: 55 }
  validates :page_order, presence: true
  validates :url, presence: true, length: { maximum: 55 }
  
  def to_param
  	url
	end
end
