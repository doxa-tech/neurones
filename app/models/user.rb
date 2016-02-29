class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :gravatar_email

  has_secure_password({ validations: false })

  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
  validates_confirmation_of :password
  validates :password, length: { minimum: 5 }
  validates :email, :format => { :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ }, uniqueness: true

  has_many :articles
  has_many :comments

  before_save :create_remember_token, :format
  before_create :gravatar

  def to_param
    "#{id}-#{name}".parameterize
  end

  def not_validate_password?
    password.blank? && password_confirmation.blank? && !self.new_record?
  end

  private

  def create_remember_token
  	self.remember_token = SecureRandom.urlsafe_base64
  end

  def format
    self.email = self.email.strip.downcase
    self.name = self.name.strip
  end

  def gravatar
    self.gravatar_email ||= self.email
  end

end
