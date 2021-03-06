class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

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
  
  validates :name, length: { maximum: 10, minimum: 2 }
  validates :gender, presence: true
  validates :birthyear, numericality: true, presence: true
  validates :height, numericality: true, presence: true
  validates :target_weight, numericality: true, presence: true
  validates :target_body_fat_percentage, numericality: true, presence: true
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
  
end
