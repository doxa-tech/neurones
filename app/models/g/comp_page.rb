class G::CompPage < ActiveRecord::Base
  attr_accessible :content
  belongs_to :page
  belongs_to :comp_group

  validates :content, presence: true

  before_create :generate_order
  
  def generate_order
    comp_page = G::CompPage.where('page_id = ?', page_id).order(:module_order).last
    if comp_page.nil?
      self.module_order = 1
    else
      self.module_order = comp_page.module_order + 1
    end
  end
end
