class G::ModuleType < ActiveRecord::Base
	has_many :modules
  attr_accessible :name
end
