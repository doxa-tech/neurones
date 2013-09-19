class G::Event < ActiveRecord::Base
  attr_accessible :content, :date, :title

  belongs_to :group

  validates :title, presence: true, length: { maximum: 55 }
  validates :content, presence: true
  validates :date, presence: true

  include PgSearch
  pg_search_scope :search, against: self.column_names,
  using: {tsearch: {dictionary: "french"}},
  associated_against: {group: :name}

	def to_param
  	"#{id}-#{title}".parameterize
	end
end
