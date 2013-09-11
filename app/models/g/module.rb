class G::Module < ActiveRecord::Base
  has_many :comp_groups, :dependent => :destroy 
  has_many :groups, through: :comp_groups

  has_many :modules, :dependent => :destroy 
  belongs_to :module
  belongs_to :module_type

  attr_accessible :name, :module_type_id, :module_id, :description, :image

  validates :name, presence: true, length: { maximum: 55 }
  validates :module_type_id, presence: true
end
