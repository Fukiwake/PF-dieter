class DiaryComment < ApplicationRecord
  belongs_to :customer
  belongs_to :diary
  has_many :notifications, dependent: :destroy
  has_many :reports, dependent: :destroy
  belongs_to :parent,  class_name: "DiaryComment", optional: true
  has_many :replies, class_name: "DiaryComment", foreign_key: :parent_id, dependent: :destroy
end
