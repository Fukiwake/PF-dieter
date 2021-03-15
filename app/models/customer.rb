class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |customer|
      customer.email = auth.info.email
      customer.password = Devise.friendly_token[0,20]
    end
  end

  enum gender: { male: 1, female: 2 }

  attachment :profile_image

  default_scope -> { order(created_at: :desc) }
  has_many :diaries, dependent: :destroy
  has_many :diet_methods, dependent: :destroy
  has_many :diary_favorites, dependent: :destroy
  has_many :diary_comments, dependent: :destroy
  has_many :diet_method_favorites, dependent: :destroy
  has_many :diet_method_comments, dependent: :destroy
  has_many :tries, dependent: :destroy
  has_many :trying_diet_methods, through: :tries, source: :diet_method
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships
  has_many :followings, through: :active_relationships, source: :followed
  has_many :active_blocks, class_name: "Block", foreign_key: "blocker_id", dependent: :destroy
  has_many :passive_blocks, class_name: "Block", foreign_key: "blocked_id", dependent: :destroy
  has_many :blockings, through: :active_blocks, source: :blocked
  has_many :entries
  has_many :chats
  has_many :rooms, through: :entries
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_many :contacts
  has_many :active_reports, class_name: "Report", foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_reports, class_name: "Report", foreign_key: 'visited_id', dependent: :destroy
  
  validates :name, length: { minimum: 1, maximum: 10 }
  validates :gender, presence: true
  validates :birthyear, numericality: {greater_than: 1000}
  validates :height, presence: true, numericality: true
  validates :target_weight, presence: true, numericality: true
  validates :target_weight, numericality: true
  validates :introduce, length: { maximum: 200 }

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
  
  def valid_of_specified?(*columns)
    columns.each do |column|
      return false if self.errors.messages.include?(column)
    end
    true
  end

  def following?(customer)
    followings.include?(customer)
  end

  def follow(customer_id)
    active_relationships.create(followed_id: customer_id)
  end

  def unfollow(customer_id)
    active_relationships.find_by(followed_id: customer_id).destroy
  end

  def blocking?(customer)
    blockings.include?(customer)
  end

  def block(customer_id)
    active_blocks.create(blocked_id: customer_id)
  end

  def unblock(customer_id)
    active_blocks.find_by(blocked_id: customer_id).destroy
  end

  def create_notification_follow(current_customer)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_customer.id, id, 'follow'])
    if temp.blank? && follow_notification == true && all_notification == true
      notification = current_customer.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def create_notification_diary(current_customer, diary)
    notification = current_customer.active_notifications.new(
      visited_id: id,
      diary_id: diary.id,
      action: 'diary'
    )
    notification.save if notification.valid?
  end
  
  def create_notification_diet_method(current_customer, diet_method)
    notification = current_customer.active_notifications.new(
      visited_id: id,
      diet_method_id: diet_method.id,
      action: 'diet_method'
    )
    notification.save if notification.valid?
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲスト"
    end
  end

  def self.guest2
    find_or_create_by!(email: 'guest2@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲスト2"
    end
  end

end
