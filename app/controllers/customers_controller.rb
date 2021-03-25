class CustomersController < ApplicationController
  before_action :authenticate_customer!, only: [:withdraw, :notification_setting]
  before_action :set_new_diary, except: [:withdraw]
  before_action :set_customer, only: [:show, :followings, :followers]

  def index
    @customers = Customer.includes(:diaries).order("created_at DESC").page(params[:page]).per(20)
  end

  def show
    @diaries = @customer.diaries.all.order(post_date: "ASC")
    # グラフに表示される日記を過去1年分に限定する
    if @diaries.present?
      @diaries = @diaries.get_one_year_diary
    end
    @weights = @diaries.pluck(:weight)
    @body_fat_percentages = @diaries.pluck(:body_fat_percentage)
    @dates = @diaries.pluck(:post_date)
    if customer_signed_in?
      @relationship = Relationship.find_by(followed_id: @customer.id, follower_id: current_customer.id)
    end
  end

  def withdraw
    if current_customer.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは退会できません'
    end
    current_customer.is_deleted = true
    current_customer.save
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  def followings
    @customers = @customer.followings.page(params[:page]).per(20)
  end

  def followers
    @customers = @customer.followers.page(params[:page]).per(20)
  end

  def ranking
    @day_ranking = Customer.includes(:diaries).order(day_exp: "DESC").order(level: "DESC").limit(20)
    @week_ranking = Customer.includes(:diaries).order(week_exp: "DESC").order(level: "DESC").limit(20)
    @month_ranking = Customer.includes(:diaries).order(month_exp: "DESC").order(level: "DESC").limit(20)
  end

  def notification_setting
    current_customer.update(customer_params)
    flash[:notice] = "通知設定を保存しました"
    redirect_to setting_path(anchor: 'notification')
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:all_notification, :comment_notification, :favorite_notification, :chat_notification, :follow_notification)
  end
end
