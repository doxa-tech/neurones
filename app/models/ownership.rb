class Ownership < ActiveRecord::Base

  belongs_to :element
  belongs_to :user
  belongs_to :right
  belongs_to :ownership_type
  
end
