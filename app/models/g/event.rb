class G::Event < ActiveRecord::Base
  attr_accessible :content, :date, :title

  belongs_to :group

  validates :title, presence: true, length: { maximum: 55 }
  validates :content, presence: true
  validates :date, presence: true

	def to_param
  	"#{id}-#{title}".parameterize
	end
end
