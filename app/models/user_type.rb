class UserType < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true, length: { maximum: 55 }

  has_many :users

  include PgSearch
  pg_search_scope :search, against: self.column_names,
  using: {tsearch: {dictionary: "french"}}
end
