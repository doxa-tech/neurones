class Group < ActiveRecord::Base
  attr_accessible :canton_id, :city, :description, :latitude, :longitude, :name, :npa, :street, :website

  belongs_to :canton

  validates :canton_id, presence: true
  validates :city, presence: true, length: { maximum: 55 }
  validates :street, presence: true, length: { maximum: 110 }
  validates :npa, presence: true, length: { is: 4 }, numericality: true
  validates :description, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :name, presence: true, length: { maximum: 55 }
  validates :website, presence: true, length: { maximum: 55 }

  module Group
  	def self.table_name_prefix
 	  	'group_'
 		end
	end
end