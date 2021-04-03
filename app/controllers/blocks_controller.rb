class BlocksController < ApplicationController
  before_action :authenticate_customer!

  def create
    @customer = Customer.find(params[:customer_id])
    current_customer.block(params[:customer_id])
    flash[:notice] = "ユーザーをブロックしました"
    #ブロックした会員からのフォローを解除
    if Relationship.find_by(follower_id: @customer.id, followed_id: current_customer.id).present?
      Relationship.find_by(follower_id: @customer.id, followed_id: current_customer.id).destroy
    end
    redirect_to request.referer
  end

  def destroy
    @customer = Customer.find(params[:customer_id])
    current_customer.unblock(params[:customer_id])
    flash[:notice] = "ユーザーのブロックを解除しました"
    redirect_to request.referer
  end
end
