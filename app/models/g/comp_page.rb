class G::CompPage < ActiveRecord::Base
  belongs_to :page
  belongs_to :comp_group
  has_one :text, :dependent => :destroy 

  before_create :generate_order
  after_create :generate_text

  private
  
  def generate_order
    if comp_page = G::CompPage.where('page_id = ?', page_id).order(:module_order).last
      self.module_order = comp_page.module_order + 1
    else
      self.module_order = 1
    end
  end

  def generate_text
    text = self.build_text
    text.content = ""
    text.page_id = page_id
    text.save
  end
end
