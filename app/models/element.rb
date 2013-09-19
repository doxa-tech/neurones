class Element < ActiveRecord::Base
  attr_accessible :name

  has_many :ownerships, :dependent => :destroy 

  validates :name, presence: true, uniqueness: true

  include PgSearch
  pg_search_scope :search, against: self.column_names,
  using: {tsearch: {dictionary: "french"}}
end
