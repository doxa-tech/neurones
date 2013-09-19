class User < ActiveRecord::Base
  require 'secure_password'
  attr_accessible :name, :email, :password, :password_confirmation, :gravatar_email, :parents_attributes

  has_secure_password({ validations: false })

  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
  validates_confirmation_of :password, :unless => lambda { |v| v.is_group? || v.is_ext_log? || v.not_validate_password? }
  validates :password, length: { minimum: 5 }, :unless => lambda { |v| v.is_group? || v.is_ext_log? || v.not_validate_password? }
  validates :email, :format => { :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i }, uniqueness: true, :unless => lambda { |v| v.is_group? || v.is_ext_log? }
  validates :user_type_id, presence: true

  has_many :articles
  has_many :comments
  has_many :ownerships, :dependent => :destroy 
  has_many :parents, :dependent => :destroy 
  belongs_to :user_type

  before_save :create_remember_token, :format
  before_create :gravatar

  accepts_nested_attributes_for :parents

  include PgSearch
  pg_search_scope :search, against: self.column_names,
  using: {tsearch: {dictionary: "french"}},
  associated_against: {user_type: :name}
  
  def to_param
    "#{id}-#{name}".parameterize
  end

  # called from omniauth callback by check_external method in session_controler
  def self.from_omniauth(auth)
    where('user_type_id = ? AND uid = ?', UserType.find_by_name(auth['provider']).id, auth['uid']).first
  end

  # called from omniauth callback by check_external method in session_controler
  # create new user
  def self.create_from_omniauth(auth)
    create! do |user|
      user.user_type_id = UserType.find_by_name(auth['provider']).id
      user.uid = auth["uid"]
      user.email = auth['info']['email']
      user.gravatar_email = auth['info']['email']
      user.name = auth["info"]["name"]
    end
  end

  def is_group?
    user_type_id == UserType.find_by_name('group').id
  end

  def is_ext_log?
    user_type_id != UserType.find_by_name('group').id && user_type_id != UserType.find_by_name('user').id
  end

  def not_validate_password?
    password.blank? && password_confirmation.blank? && !self.new_record?
  end

  private

  def create_remember_token
  	self.remember_token = SecureRandom.urlsafe_base64
  end

  def format
    self.email = self.email.strip.downcase unless is_group?
    self.name = self.name.strip
  end

  def gravatar
    self.gravatar_email ||= self.email
  end

end
