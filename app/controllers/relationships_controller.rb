class RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @customer = Customer.find(params[:customer_id])
    if Block.where(blocker_id: @customer.id, blocked_id: current_customer.id).present?
      flash[:alert] = "このユーザーはフォローできません"
      redirect_to request.referer
    else
      current_customer.follow(params[:customer_id])
      if CustomerAchievement.where(customer_id: current_customer.id, achievement_id: 4, achievement_status: true).blank?
        CustomerAchievement.create(customer_id: current_customer.id, achievement_id: 4, achievement_status: true)
        flash[:achievement] = "4"
        level_up(10, current_customer)
      end
      @customer.create_notification_follow(current_customer)
      @relationship = Relationship.find_by(followed_id: params[:customer_id], follower_id: current_customer.id)
    end
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end

  def destroy
    @customer = Customer.find(params[:customer_id])
    current_customer.unfollow(params[:customer_id])
  end

  def update
    @relationship = Relationship.find_by(followed_id: params[:customer_id], follower_id: current_customer.id)
    @relationship.update(notification: params[:notification])
    @customer = Customer.find(params[:customer_id])
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end
end
