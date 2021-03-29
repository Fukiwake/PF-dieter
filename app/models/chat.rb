class Chat < ApplicationRecord
  belongs_to :room
  belongs_to :customer
  has_many :notifications, dependent: :destroy
end
