class DietMethodComment < ApplicationRecord
  
  belongs_to :diet_method
  belongs_to :customer
  has_many :notifications, dependent: :destroy
  
end
