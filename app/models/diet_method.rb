class DietMethod < ApplicationRecord
  has_many :diet_method_images, dependent: :destroy
  accepts_attachments_for :diet_method_images, attachment: :image
  acts_as_taggable

  belongs_to :customer
  has_many :check_lists
  accepts_nested_attributes_for :check_lists, allow_destroy: true
  has_many :diet_method_favorites, dependent: :destroy
  has_many :diet_method_comments, dependent: :destroy
  has_many :tries, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :reports, dependent: :destroy


  validates :title, presence: true, length: { maximum: 15 }
  validates :way, presence: true

  ransacker :diet_method_favorites_count do
    query = '(SELECT COUNT(diet_method_favorites.diet_method_id) FROM diet_method_favorites where diet_method_favorites.diet_method_id = diet_methods.id GROUP BY diet_method_favorites.diet_method_id)'
    Arel.sql(query)
  end

  ransacker :diet_method_comments_count do
    query = '(SELECT COUNT(diet_method_comments.diet_method_id) FROM diet_method_comments where diet_method_comments.diet_method_id = diet_methods.id GROUP BY diet_method_comments.diet_method_id)'
    Arel.sql(query)
  end

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

  def create_notification_comment(current_customer, diet_method_comment_id)
    if customer.comment_notification == true && customer.all_notification == true
      # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
      notification = current_customer.active_notifications.new(
        diet_method_id: id,
        diet_method_comment_id: diet_method_comment_id,
        visited_id: customer_id,
        action: 'diet_method_reply'
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end


end
