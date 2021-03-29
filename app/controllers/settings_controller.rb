class SettingsController < ApplicationController
  before_action :authenticate_customer!

  def setting
    @blocking_customers = current_customer.blockings
    notification_customers_ids = current_customer.active_relationships.where(notification: true).pluck(:followed_id)
    @notification_customers = Customer.where(id: notification_customers_ids)
  end
end
