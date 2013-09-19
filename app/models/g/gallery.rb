class G::Gallery < ActiveRecord::Base
  belongs_to :group
  has_many :paintings
  attr_accessible :date, :name, :description

  validates :name, presence: true, length: { maximum: 55 }
  validates :description, presence: true
  validates :date, presence: true

  include PgSearch
  pg_search_scope :search, against: self.column_names,
  using: {tsearch: {dictionary: "french"}},
  associated_against: {group: :name}
	
	def to_param
  	"#{id}-#{name}".parameterize
	end
end
