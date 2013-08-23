class G::Text < ActiveRecord::Base
  belongs_to :page
  belongs_to :comp_page
  attr_accessible :content

  before_create :generate_order

  private
  
  def generate_order
    if text = G::Text.where('page_id = ?', page_id).order(:text_order).last
      self.text_order = text.text_order + 1
    else
      self.text_order = 1
    end
  end
end
