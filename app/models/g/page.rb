class G::Page < ActiveRecord::Base
  has_many :texts, :dependent => :destroy 
  has_many :comp_pages, :dependent => :destroy 
  has_many :comp_groups, through: :comp_pages
  belongs_to :group
  attr_accessible :name, :page_order, :url
  
  validates :name, presence: true, length: { maximum: 55 }
  validates :page_order, presence: true
  validates :url, presence: true, format: { with: /\A[a-z0-9-]+\z/ }, length: { maximum: 55 }
  validate :url_already_taken?

  after_create :generate_text
  
  def to_param
  	url
	end

  private

  def url_already_taken?
    if !url.nil? && G::Page.where('group_id = ?', group_id).map{ |p| p.url }.include?(url)
      errors.add(:url, "n'est pas disponible.")
    end
  end

  def generate_text
    self.texts.create(content: "Bienvenue")
  end
end
