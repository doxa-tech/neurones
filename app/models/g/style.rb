class G::Style < ActiveRecord::Base
  attr_accessible :content, :name

  validates :name, presence: true, uniqueness: true
  validates :content, presence: true
  validates :theme, presence: true

  has_many :groups
end
