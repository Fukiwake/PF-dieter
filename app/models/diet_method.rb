class DietMethod < ApplicationRecord
  
  attachment :image
  acts_as_taggable
  
  belongs_to :customer
  has_many :check_lists
  has_many :diet_method_favorites, dependent: :destroy
  has_many :diet_method_comments, dependent: :destroy
  accepts_nested_attributes_for :check_lists, allow_destroy: true
  
  def favorited_by?(customer)
    diet_method_favorites.where(customer_id: customer.id).exists?
  end
  
end
