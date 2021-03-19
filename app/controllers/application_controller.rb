class ApplicationController < ActionController::Base
  before_action :set_header_notification
  before_action :set_customer_search

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
    level_settings = LevelSetting.where("level > #{customer.level}").limit(2)
    level_settings.each do |setting|
      if setting.threshold <= customer.total_exp
        customer.update(level: setting.level, total_exp: customer.total_exp - setting.threshold)
      end
    end
  end

  def set_new_diary
    @diary = Diary.new
    @check_list_diary = @diary.check_list_diaries.new
  end

  def set_header_notification
    if customer_signed_in?
      @header_notifications = current_customer.passive_notifications.where.not(visitor_id: current_customer.id, checked: true)
    end
  end

  def set_customer_search
    @customer_search = Customer.includes(:diaries).ransack(params[:q])
  end

end
