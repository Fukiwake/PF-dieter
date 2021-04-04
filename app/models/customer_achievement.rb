class CustomerAchievement < ApplicationRecord
  
  belongs_to :customer
  belongs_to :achievement
end
