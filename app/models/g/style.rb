class G::Style < ActiveRecord::Base
  attr_accessible :content, :name

  has_many :groups
end
