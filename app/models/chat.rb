class Chat < ApplicationRecord
  
  belongs_to :room
  belongs_to :customer
  
end
