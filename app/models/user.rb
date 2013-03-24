class User < ActiveRecord::Base
  attr_accessible :name, :level_id, :password, :password_confirmation

  has_secure_password

  validates :name, presence: true, length: { maximum: 55 }
  validates :level_id, presence: true
  validates :password, length: { minimum: 5 }, :unless => "password.blank?" 
  validates :password_confirmation, presence: true, :unless => "password.blank?" 

  belongs_to :level, :inverse_of => :users

  before_save :create_remember_token, :format

  private

  def create_remember_token
  	self.remember_token = SecureRandom.urlsafe_base64
  end

  def format
    self.name = self.name.gsub(/\s+/, "").downcase
  end
end
