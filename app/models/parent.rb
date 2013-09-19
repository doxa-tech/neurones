class Parent < ActiveRecord::Base
	attr_accessible :user_id, :parent_id
	
  belongs_to :user
  belongs_to :parent, class_name: User

  validates :user_id, presence: true
  validates :parent_id, presence: true

  include PgSearch
  pg_search_scope :search, against: self.column_names,
  using: {tsearch: {dictionary: "french"}},
  associated_against: {user: :name, parent: :name}
end
