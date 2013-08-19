class Group < ActiveRecord::Base
  attr_accessible :canton_id, :city, :description, :latitude, :longitude, :name, :npa, :street, :website

  belongs_to :canton
  has_many :pages, class_name: G::Page, :dependent => :destroy 
  has_many :comp_groups, class_name: G::CompGroup, :dependent => :destroy 
  has_many :modules, class_name: G::Module, through: :comp_groups

  validates :canton_id, presence: true
  validates :city, presence: true, length: { maximum: 55 }
  validates :street, presence: true, length: { maximum: 110 }
  validates :npa, presence: true, length: { is: 4 }, numericality: true
  validates :description, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :name, presence: true, length: { maximum: 55 }
  validates :website, length: { maximum: 55 }
  validates :url, uniqueness: true, presence: true, format: { with: /\A[a-z0-9-]+\z/ }, length: { maximum: 55 }, if: :activation?
  validate :url_already_taken?, if: :activation?
  
  before_create :generate_url
  
  def to_param
    url
  end
  
  def activation?
    website_activated == true
  end
  
  def url_already_taken?
    if !url.nil? && Rails.application.routes.routes.map{|route| route.path.spec.to_s }.include?('/' + url + '(.:format)')
      errors.add(:url, "n'est pas disponible.")
    end
  end
  
  private
  
  def generate_url
    self.url = self.id
  end
end
