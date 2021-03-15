class RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @customer = Customer.find(params[:customer_id])
    current_customer.follow(params[:customer_id])
    @customer.create_notification_follow(current_customer)
    @relationship = Relationship.find_by(followed_id: params[:customer_id], follower_id: current_customer.id)
  end

  def destroy
    @customer = Customer.find(params[:customer_id])
    current_customer.unfollow(params[:customer_id])
  end

  def update
    @relationship = Relationship.find_by(followed_id: params[:customer_id], follower_id: current_customer.id)
    @relationship.update(notification: params[:notification])
    @customer = Customer.find(params[:customer_id])
  end

end
