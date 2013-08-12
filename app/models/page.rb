class Page < ActiveRecord::Base
  attr_accessible :content, :name, :title

  validates :content, presence: true
  validates :name, presence: true, length: { maximum: 55 }, uniqueness: true
  validates :title, presence: true, length: { maximum: 55 }

	before_save :format_title

  private

  def format_title
    self.title = strip_tags(self.title)
  end
end
