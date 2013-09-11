class G::Style < ActiveRecord::Base
  attr_accessible :content, :name, :image, :description

  validates :name, presence: true, uniqueness: true, length: { maximum: 55 }
  validates :content, presence: true

  has_many :groups
end
