class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [:show, :edit, :update]

  def index
    @customer_search = Customer.ransack(params[:q])
    @customers = @customer_search.result(distinct: true).page(params[:page]).per(20)
  end

  def show
    @diaries = @customer.diaries.all.order(post_date: "ASC")
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = "ユーザーを編集しました"
      redirect_to admin_customers_path
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
    params.require(:customer).permit(:email, :name, :profile_image, :introduce, :gender, :birthyear, :birthdate, :height, :target_weight, :target_body_fat_percentage, :diet_style1, :diet_style2, :diet_style3, :diet_style4, :is_deleted)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
