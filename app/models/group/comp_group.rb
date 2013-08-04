class Group::CompGroup < ActiveRecord::Base
  has_many :comp_pages, :dependent => :destroy 
  has_many :pages, through: :comp_pages
  belongs_to :group
  belongs_to :module
  # attr_accessible :title, :body
end
