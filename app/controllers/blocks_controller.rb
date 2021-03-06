class BlocksController < ApplicationController
  
  def create
    @customer = Customer.find(params[:customer_id])
    current_customer.block(params[:customer_id])
  end
  
  def destroy
    @customer = Customer.find(params[:customer_id])
    current_customer.unblock(params[:customer_id])
  end
  
end
