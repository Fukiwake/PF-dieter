# frozen_string_literal: true

class Customers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_inactive_customer, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # 退会済みユーザーのログインをブロック
  def reject_inactive_customer
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer.present?
      if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted == true
        flash[:danger] = "退会済みのユーザーです。"
        redirect_to new_customer_session_path
      end
    end
  end

  def new_guest
    customer = Customer.guest
    get_achievement(customer, 1)
    sign_in customer
    redirect_to diaries_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def new_guest2
    customer = Customer.guest2
    get_achievement(customer, 1)
    sign_in customer
    redirect_to diaries_path, notice: 'ゲストユーザー2としてログインしました。'
  end
end
