class DietMethod < ApplicationRecord
  
  attachment :image
  
  belongs_to :customer
  has_many :check_lists
  accepts_nested_attributes_for :check_lists, allow_destroy: true
end
