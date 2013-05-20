class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :user_type_id

  has_secure_password

  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
  validates :password, length: { minimum: 5 }, :unless => "password.blank?" 
  validates :password_confirmation, presence: true, :unless => "password.blank?" 
  validates :email, presence: true, length: { maximum: 55 }, :format => { :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i }
  validates :user_type_id, presence: true

  has_many :articles
  has_many :comments
  has_many :ownerships
  belongs_to :user_type

  before_save :create_remember_token, :format

  private

  def create_remember_token
  	self.remember_token = SecureRandom.urlsafe_base64
  end

  def format
    self.email = self.email.gsub(/\s+/, "").downcase
  end
end
