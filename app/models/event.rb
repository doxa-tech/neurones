class Event < ActiveRecord::Base
  attr_accessible :title, :content, :date
  belongs_to :image
  belongs_to :events_type

  validates :date, presence: true
  validates :title, presence: true, length: { maximum: 55 }
  validates :content, presence: true

	def to_param
  	"#{id}-#{theme}".parameterize
	end
end
