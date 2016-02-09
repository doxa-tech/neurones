class G::Style < ActiveRecord::Base
  attr_accessible :content, :name, :image, :description

  validates :name, presence: true, uniqueness: true, length: { maximum: 55 }
  validates :content, presence: true

  has_many :groups

  def banner_path
    puts content.scan(/.banner\s*{(?:.*\n)*\s*background-image:\s*url\((.*)\)(?:.*\n)*}/).first
  end

end
