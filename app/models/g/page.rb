class G::Page < ActiveRecord::Base
  has_many :texts, :dependent => :destroy
  has_many :comp_pages, :dependent => :destroy
  has_many :comp_groups, through: :comp_pages
  belongs_to :group
  attr_accessible :name, :page_order, :url

  validates :name, presence: true, length: { maximum: 55 }
  validates :url, presence: true, format: { with: /\A[a-z0-9-]+\z/ }, length: { maximum: 55 }
  validate :url_already_taken?

  after_create :generate_text
  before_create :generate_order

  def to_param
  	url
	end

  private

  def url_already_taken?
    if G::Page.where('group_id = ? and url = ? and id != ?', group_id, url, (id or 0) ).any?
      errors.add(:url, "n'est pas disponible.")
    end
  end

  def generate_text
    self.texts.create(content: "Bienvenue")
  end

  def generate_order
    if page = G::Page.where('group_id = ?', group_id).order(:page_order).last
      self.page_order = page.page_order + 1
    else
      self.page_order = 1
    end
  end
end
