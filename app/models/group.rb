class Group < ActiveRecord::Base
  attr_accessible :canton_id, :city, :description, :latitude, :longitude, :name, :npa, :street, :website

  belongs_to :canton
  belongs_to :style, class_name: G::Style
  has_many :pages, class_name: G::Page, :dependent => :destroy 
  has_many :comp_groups, class_name: G::CompGroup, :dependent => :destroy 
  has_many :modules, class_name: G::Module, through: :comp_groups

  has_many :events, class_name: G::Event
  has_many :news, class_name: G::New
  has_many :galleries, class_name: G::Gallery
  has_many :images, class_name: G::Image

  validates :canton_id, presence: true
  validates :city, presence: true, length: { maximum: 55 }
  validates :street, presence: true, length: { maximum: 110 }
  validates :npa, presence: true, length: { is: 4 }, numericality: true
  validates :description, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :name, presence: true, length: { maximum: 55 }, uniqueness: true
  validates :website, length: { maximum: 55 }
  validates :url, uniqueness: true, presence: true, format: { with: /\A[a-z0-9-]+\z/ }, length: { maximum: 55 }
  validate :url_already_taken?

  before_create :create_style
  before_destroy :destroy_style
    
  def to_param
    url
  end
  
  private

  def create_style
    theme = G::Style.find_by_name_and_theme('default', true)
<<<<<<< HEAD
    style = G::Style.new(name: name, content: theme.content)
=======
    style = self.style.new(name: name, content: theme.content)
>>>>>>> groups
    style.theme = false
    style.save
    self.style_id = style.id
  end

  def destroy_style
    self.style.destroy
  end
  
  def url_already_taken?
    if !url.nil? && Rails.application.routes.routes.map{|route| route.path.spec.to_s }.include?('/' + url + '(.:format)')
      errors.add(:url, "n'est pas disponible.")
    end
  end

end
