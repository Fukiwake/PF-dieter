class Diary < ApplicationRecord

  has_many :diary_images, dependent: :destroy
  accepts_attachments_for :diary_images, attachment: :image
  belongs_to :customer
  has_many :diary_favorites, dependent: :destroy
  has_many :diary_comments, dependent: :destroy
  has_many :check_list_diaries
  accepts_nested_attributes_for :check_list_diaries, allow_destroy: true
  has_many :notifications, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :title, length: { maximum: 15 }
  validates :weight, numericality: true, presence: true
  validates :body_fat_percentage, numericality: true, allow_blank: true
  validates :body, length: { maximum: 200 }

  ransacker :diary_favorites_count do
    query = '(SELECT COUNT(diary_favorites.diary_id) FROM diary_favorites where diary_favorites.diary_id = diaries.id GROUP BY diary_favorites.diary_id)'
    Arel.sql(query)
  end

  ransacker :diary_comments_count do
    query = '(SELECT COUNT(diary_comments.diary_id) FROM diary_comments where diary_comments.diary_id = diaries.id GROUP BY diary_comments.diary_id)'
    Arel.sql(query)
  end

  def self.get_one_year_diary
    if self.first.post_date < self.last.post_date.prev_year
      self.where("post_date > ?",self.last.post_date.prev_year)
    else
      self.all
    end
  end

  def start_time
    self.post_date
  end

  def favorited_by?(customer)
    diary_favorites.where(customer_id: customer.id).exists?
  end

  def create_notification_favorite(current_customer)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and diary_id = ? and action = ? ", current_customer.id, customer_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank? && customer.favorite_notification == true && customer.all_notification == true
      notification = current_customer.active_notifications.new(
        diary_id: id,
        visited_id: customer_id,
        action: 'diary_favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment(current_customer, diary_comment_id)
    if customer.comment_notification == true && customer.all_notification == true
      # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
      notification = current_customer.active_notifications.new(
        diary_id: id,
        diary_comment_id: diary_comment_id,
        visited_id: customer_id,
        action: 'diary_comment'
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

end
