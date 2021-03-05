class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :diaries, dependent: :destroy
  has_many :diet_methods, dependent: :destroy

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
end
