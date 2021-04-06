class CustomersController < ApplicationController
  before_action :authenticate_customer!, only: [:withdraw, :notification_setting]
  before_action :set_new_diary, except: [:withdraw]
  before_action :set_customer, only: [:show, :followings, :followers]

  def index
    @customers = Customer.includes(:diaries).where(is_deleted: false).order("created_at DESC")
    if params[:q].present?
      get_achievement(current_customer, 10)
      unless params[:q][:name_or_introduce_cont_any].instance_of?(Array) || params[:q][:name_or_introduce_cont_any].empty?
        params[:q][:name_or_introduce_cont_any] = params[:q][:name_or_introduce_cont_any].split(/[\p{blank}\s]+/)
      end
    end
    @customer_search = @customers.ransack(params[:q])
    @customers = @customer_search.result(distinct: true).page(params[:page]).per(20)
  end

  def show
    # グラフに表示される日記を過去1年分に限定する
    @diaries = @customer.diaries.all.order(post_date: "ASC")
    if @diaries.present?
      @diaries = @diaries.get_one_year_diary
    end
    @weights = @diaries.pluck(:weight)
    @body_fat_percentages = @diaries.pluck(:body_fat_percentage)
    @dates = @diaries.pluck(:post_date)
    if customer_signed_in?
      @relationship = Relationship.find_by(followed_id: @customer.id, follower_id: current_customer.id)
    end
    all_diaries = Diary.includes(:check_list_diaries, :diary_images, :diary_favorites, :diary_comments, :customer).order("created_at DESC")
    @post_diaries = all_diaries.where(customer_id: @customer.id).page(params[:page]).per(20)
    favorite_diary_ids = @customer.diary_favorites.pluck(:diary_id)
    @favorite_diaries = all_diaries.where(id: favorite_diary_ids).page(params[:page]).per(20)
    all_diet_methods = DietMethod.includes(:diet_method_images, :diet_method_favorites, :diet_method_comments, :tag_taggings, :tags, :customer).order("created_at DESC")
    @post_diet_methods = all_diet_methods.where(customer_id: @customer.id).page(params[:page]).per(20)
    favorite_diet_method_ids = @customer.diet_method_favorites.pluck(:diet_method_id)
    @favorite_diet_methods = all_diet_methods.where(id: favorite_diet_method_ids).page(params[:page]).per(20)
  end

  def withdraw
    if current_customer.email == 'guest@example.com' || current_customer.email == 'guest2@example.com'
      redirect_to(root_path, alert: 'ゲストユーザーは退会できません') && return
    end
    current_customer.is_deleted = true
    current_customer.save
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to(root_path) && return
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
