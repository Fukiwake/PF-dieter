class DietStyle < ApplicationRecord
  
  has_many :customer_diet_styles, dependent: :destroy
end
