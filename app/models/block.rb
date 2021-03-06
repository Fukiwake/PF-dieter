class Block < ApplicationRecord
  
  belongs_to :blocker, class_name: "Customer"
  belongs_to :blocked, class_name: "Customer"
  
end
