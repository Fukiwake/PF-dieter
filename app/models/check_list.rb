class CheckList < ApplicationRecord
  
  belongs_to :diet_method
  has_many :check_list_diaries
  
end
