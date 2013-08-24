class G::Module < ActiveRecord::Base
  has_many :comp_groups, :dependent => :destroy 
  has_many :groups, through: :comp_groups

  has_many :modules
  belongs_to :module
  belongs_to :module_type

  attr_accessible :content, :name, :module_type_id
end
