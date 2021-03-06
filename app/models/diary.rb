class Diary < ApplicationRecord
  
  attachment :image

  belongs_to :customer
  has_many :diary_favorites, dependent: :destroy
  has_many :diary_comments, dependent: :destroy
  has_many :check_list_diaries
  has_many :checked_lists, through: :check_list_diaries, source: :check_list
  accepts_nested_attributes_for :check_list_diaries, allow_destroy: true

  validates :weight, numericality: true, presence: true
  validates :body_fat_percentage, numericality: true


  def self.get_one_year_diary
    if self.first.post_date < self.last.post_date.prev_year
      self.where("post_date > ?",self.last.post_date.prev_year)
    else
      self.all
    end
  end
  
  def favorited_by?(customer)
    diary_favorites.where(customer_id: customer.id).exists?
  end
end
