class Ownership < ActiveRecord::Base
	attr_accessible :element_id, :user_id, :ownership_type_id, :right_read, :right_create, :right_update, :right_delete, :id_element

  belongs_to :element
  belongs_to :user
  belongs_to :ownership_type

  validates :element_id, presence: true
  validates :user_id, presence: true
  validates :ownership_type_id, presence: true
end
