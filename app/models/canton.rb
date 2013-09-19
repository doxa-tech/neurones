class Canton < ActiveRecord::Base
  attr_accessible :name

  has_many :groups

  validates :name, presence: true, length: { maximum: 55 }

  include PgSearch
  pg_search_scope :search, against: self.column_names,
  using: {tsearch: {dictionary: "french"}}
end
