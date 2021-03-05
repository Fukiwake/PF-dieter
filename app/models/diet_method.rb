class DietMethod < ApplicationRecord
  
  attachment :image
  
  belongs_to :customer
  has_many :check_lists
  has_many :check_list_collections
  accepts_nested_attributes_for :check_list_collections, allow_destroy: true
end
