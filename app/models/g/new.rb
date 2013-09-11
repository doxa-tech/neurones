class G::New < ActiveRecord::Base
  attr_accessible :content, :date_exp, :title

  belongs_to :group
end
