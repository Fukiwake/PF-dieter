class DietMethodImage < ApplicationRecord
  belongs_to :diet_method
  attachment :image
end
