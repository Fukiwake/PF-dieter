class DietMethod < ApplicationRecord
  
  attachment :image
  acts_as_taggable
  
  belongs_to :customer
  has_many :check_lists
  accepts_nested_attributes_for :check_lists, allow_destroy: true
end
