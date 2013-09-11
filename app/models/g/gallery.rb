class G::Gallery < ActiveRecord::Base
  belongs_to :group
  has_many :paintings
  attr_accessible :date, :name, :description

  validates :name, presence: true, length: { maximum: 55 }, uniqueness: true
  validates :description, presence: true
  validates :date, presence: true
	
	def to_param
  	"#{id}-#{name}".parameterize
	end
end
