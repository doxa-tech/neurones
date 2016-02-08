class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :gravatar_email

  has_secure_password({ validations: false })

  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
  validates_confirmation_of :password, :unless => lambda { |v| v.is_group? || v.is_ext_log? || v.not_validate_password? }
  validates :password, length: { minimum: 5 }, :unless => lambda { |v| v.is_group? || v.is_ext_log? || v.not_validate_password? }
  validates :email, :format => { :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ }, uniqueness: true, :unless => lambda { |v| v.is_group? || v.is_ext_log? }
  validates :user_type_id, presence: true

  has_many :articles
  has_many :comments
  has_many :ownerships, :dependent => :destroy
  has_many :parents, :dependent => :destroy
  has_many :users, through: :parents
  belongs_to :user_type

  before_save :create_remember_token, :format
  before_create :gravatar

  def to_param
    "#{id}-#{name}".parameterize
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
