class User < ActiveRecord::Base
  require 'secure_password'
  attr_accessible :name, :email, :password, :password_confirmation, :user_type_id, :uid, :parents_attributes

  has_secure_password({ validations: false })

  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
  validates_confirmation_of :password
  validates :password, length: { minimum: 5 }, on: :create, :unless => :is_group?
  validates :password_confirmation, presence: true, on: :create, :unless => :is_group?
  validates :email, presence: true, length: { maximum: 55 }, :format => { :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i }, :unless => :is_group?
  validates :user_type_id, presence: true

  has_many :articles
  has_many :comments
  has_many :ownerships
  has_many :parents
  belongs_to :user_type

  before_save :create_remember_token, :format, :gravatar

  accepts_nested_attributes_for :parents

  
  def to_param
    "#{id}-#{name}".parameterize
  end

  # called from omniauth callback by check_external method in session_controler
  def self.from_omniauth(auth)
    where('user_type_id = ? AND uid = ?', UserType.find_by_name(auth['provider']).id, auth['uid']).first
  end

  # called from omniauth callback by check_external method in session_controler
  def self.create_from_omniauth(auth)
    create! do |user|
      user.user_type_id = UserType.find_by_name(auth['provider']).id
      user.uid = auth["uid"]
      user.email = auth['info']['email']
      user.name = auth["info"]["name"]
      user.password = 'ext_log_1234'
      user.password_confirmation = 'ext_log_1234'
    end
  end

  private

  def create_remember_token
  	self.remember_token = SecureRandom.urlsafe_base64
  end

  def format
    self.email = self.email.gsub(/\s+/, "").downcase unless self.email.nil?
  end

  def gravatar
    self.gravatar_email = self.email
  end

  def is_group?
    user_type_id == UserType.find_by_name('group').id
  end
end
