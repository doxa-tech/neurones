class G::ModuleType < ActiveRecord::Base
	has_many :modules
  attr_accessible :name

  validates :name, presence: true, length: { maximum: 55 }
end
