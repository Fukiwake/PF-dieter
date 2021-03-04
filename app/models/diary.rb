class Diary < ApplicationRecord
  
  attachment :image

  belongs_to :customer

  validates :weight, numericality: true, presence: true
  validates :body_fat_percentage, numericality: true, presence: true
  validates :title, length: { maximum: 20 }, presence: true

  def self.get_one_year_diary
    if self.first.post_date < self.last.post_date.prev_year
      self.where("post_date > ?",self.last.post_date.prev_year)
    else
      self.all
    end
  end
end
