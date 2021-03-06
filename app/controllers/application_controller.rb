class ApplicationController < ActionController::Base
  before_action :set_header_notification
  before_action :set_customer_search
  before_action :set_available_tags_to_gon
  before_action :is_deleted?, if: proc { customer_signed_in? && current_customer.is_deleted == true }

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_customers_path
    when Customer
      diaries_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def level_up(exp, customer)
    total_exp = customer.total_exp + exp
    day_exp = customer.day_exp + exp
    week_exp = customer.week_exp + exp
    month_exp = customer.month_exp + exp
    customer.update(total_exp: total_exp, day_exp: day_exp, week_exp: week_exp, month_exp: month_exp)
    #会員の現在のレベルより高いレベルしきい値を取得
    level_settings = LevelSetting.where("level > #{customer.level}").limit(2)
    level_settings.each do |setting|
      #現在の経験値がしきい値より高い場合レベルアップ
      if setting.threshold <= customer.total_exp
        customer.update(level: setting.level, total_exp: customer.total_exp - setting.threshold)
        flash[:alert] = "レベルが#{setting.level}に上がりました！"
      end
    end
  end

  def set_new_diary
    @diary = Diary.new
    @check_list_diary = @diary.check_list_diaries.new
  end

  def set_header_notification
    if customer_signed_in?
      @header_notifications = current_customer.passive_notifications.includes(:diet_method, :diet_method_comment, :diary, :diary_comment).where.not(visitor_id: current_customer.id, checked: true)
    end
  end

  def set_customer_search
    @customer_search = Customer.includes(:diaries).ransack(params[:q])
  end

  def set_available_tags_to_gon
    gon.available_tags = DietMethod.tags_on(:tags).pluck(:name)
  end

  def is_deleted?
    sign_out
    flash[:alert] = "このアカウントはすでに退会されています。"
    redirect_to new_customer_session_path
  end

  def get_achievement(current_customer, n)
    if CustomerAchievement.where(customer_id: current_customer.id, achievement_id: n, achievement_status: true).blank?
      CustomerAchievement.create(customer_id: current_customer.id, achievement_id: n, achievement_status: true)
      flash[:achievement] = n
      level_up(10, current_customer)
      current_customer.update(achievement_count: current_customer.achievement_count + 1)
    end
  end
end
