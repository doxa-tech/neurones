class Event < ActiveRecord::Base
  attr_accessible :title, :content, :date
  belongs_to :image

	def to_param
  	"#{id}-#{title}".parameterize
	end
end
