class NotificationsController < ApplicationController
  before_action :set_new_diary

  def index
    @notifications = current_customer.passive_notifications.page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    @notifications = @notifications.where.not(visitor_id: current_customer.id)
  end

  def checked
    @header_notifications.each do |notification|
      notification.update(checked: true)
    end
  end

end
