class G::Style < ActiveRecord::Base
  attr_accessible :content, :name, :image, :description

  validates :name, presence: true, uniqueness: true, length: { maximum: 55 }
  validates :content, presence: true

  has_many :groups

  include PgSearch
  pg_search_scope :search, against: self.column_names,
  using: {tsearch: {dictionary: "french"}}
end
