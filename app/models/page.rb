class Page < ActiveRecord::Base
	include ActionView::Helpers::SanitizeHelper
  attr_accessible :content, :name, :title

  validates :content, presence: true
  validates :name, presence: true, length: { maximum: 55 }, uniqueness: true
  validates :title, presence: true, length: { maximum: 55 }

	before_save :format_title

  include PgSearch
  pg_search_scope :search, against: self.column_names,
  using: {tsearch: {dictionary: "french"}}

  private

  def format_title
    self.title = CGI.unescapeHTML(strip_tags self.title)
  end
end
