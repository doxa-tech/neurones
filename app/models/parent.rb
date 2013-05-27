class Parent < ActiveRecord::Base
	attr_accessible :user_id, :parent_id
	
  belongs_to :user
  belongs_to :parent
end
