class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [:show, :edit, :update]
  
  def index
    @customers = Customer.page(params[:page])
  end
  
  def show
    @diaries = @customer.diaries.all.order(post_date: "ASC")
  end
  
  def edit
  end
  
  def update
    if @customer.update(customer_params)
      flash[:notice] = "ユーザーを編集しました"
      redirect_to admin_customers_path(@customer)
    else
      render :edit
    end
  end
  
  def withdraw_all
    Customer.where(id: params[:customer_ids]).update(is_deleted: true)
    flash[:notice] = "選択したユーザーが退会済みになりました"
    redirect_to admin_customers_path
  end
  
  private 
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, :email, :is_deleted)
  end
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
end
