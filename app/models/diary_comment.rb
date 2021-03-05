class DiaryComment < ApplicationRecord
  
  belongs_to :customer
  belongs_to :diary
  
end
