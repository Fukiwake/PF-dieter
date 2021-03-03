class CustomerDietStyle < ApplicationRecord
  
  belongs_to :customer
  belongs_to :diet_style
end
