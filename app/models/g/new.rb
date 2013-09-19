class G::New < ActiveRecord::Base
  attr_accessible :content, :date_exp, :title

  belongs_to :group

  validates :content, presence: true
  validates :date_exp, presence: true
  validates :title, presence: true, length: { maximum: 55 }
end
