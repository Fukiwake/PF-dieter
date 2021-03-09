class DietMethod < ApplicationRecord
  
  attachment :image
  acts_as_taggable
  
  default_scope -> { order(created_at: :desc) }
  belongs_to :customer
  has_many :check_lists
  accepts_nested_attributes_for :check_lists, allow_destroy: true
  has_many :diet_method_favorites, dependent: :destroy
  has_many :diet_method_comments, dependent: :destroy
  has_many :tries, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  validates :title, presence: true
  
  def favorited_by?(customer)
    diet_method_favorites.where(customer_id: customer.id).exists?
  end
  
  def tried_by?(customer)
    tries.where(customer_id: customer.id).exists?
  end
  
  def create_notification_favorite(current_customer)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and diet_method_id = ? and action = ? ", current_customer.id, customer_id, id, 'diet_method_favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank? && customer.favorite_notification == true && customer.all_notification == true
      notification = current_customer.active_notifications.new(
        diet_method_id: id,
        visited_id: customer_id,
        action: 'diet_method_favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  def create_notification_comment(current_customer, diet_method_comment_id)
    if customer.comment_notification == true && customer.all_notification == true
      # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
      notification = current_customer.active_notifications.new(
        diet_method_id: id,
        diet_method_comment_id: diet_method_comment_id,
        visited_id: customer_id,
        action: 'diet_method_comment'
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
end
