class RelationshipsController < ApplicationController
  
  def create
    @customer = Customer.find(params[:customer_id])
    current_customer.follow(params[:customer_id])
    @customer.create_notification_follow(current_customer)
  end
  
  def destroy
    @customer = Customer.find(params[:customer_id])
    current_customer.unfollow(params[:customer_id])
  end
  
end
