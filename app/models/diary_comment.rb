class DiaryComment < ApplicationRecord
  
  belongs_to :customer
  belongs_to :diary
  has_many :notifications, dependent: :destroy
  
end
