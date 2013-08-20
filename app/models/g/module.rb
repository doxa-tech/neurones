class G::Module < ActiveRecord::Base
  has_many :comp_groups, :dependent => :destroy 
  has_many :groups, through: :comp_groups
  attr_accessible :content, :name
end
