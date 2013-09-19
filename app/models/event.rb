class Event < ActiveRecord::Base
  attr_accessible :title, :content, :date
  belongs_to :image

  validates :title, presence: true, length: { maximum: 55 }
  validates :content, presence: true
  validates :date, presence: true

  include PgSearch
  pg_search_scope :search, against: self.column_names,
  using: {tsearch: {dictionary: "french"}}

	def to_param
  	"#{id}-#{title}".parameterize
	end
end
