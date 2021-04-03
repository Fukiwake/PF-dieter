class DietMethodComment < ApplicationRecord
  belongs_to :diet_method
  belongs_to :customer
  has_many :notifications, dependent: :destroy
  has_many :reports, dependent: :destroy
  belongs_to :parent,  class_name: "DietMethodComment", optional: true
  has_many :replies, class_name: "DietMethodComment", foreign_key: :parent_id, dependent: :destroy
end
