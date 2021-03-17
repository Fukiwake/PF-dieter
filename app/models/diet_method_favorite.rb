class DietMethodFavorite < ApplicationRecord
  
  belongs_to :diet_method
  belongs_to :customer
  
end
