# frozen_string_literal: true

class Customers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create, :create_profile]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    @customer = Customer.new(sign_up_params)
    @customer.valid?
    unless @customer.valid_of_specified?(:email, :password)
      flash.now[:alert] = "メールアドレスかパスワードが正しくありません"
      render :new and return
    end
    session["devise.regist_data"] = {customer: @customer.attributes}
    session["devise.regist_data"][:customer]["password"] = params[:customer][:password]
    redirect_to customers_new_profile_path
  end

  def new_profile
    @customer = Customer.new
  end

  def create_profile
    @customer = Customer.new(session["devise.regist_data"]["customer"])
    @customer.update(sign_up_params)
    if @customer.save
      flash[:notice] = "新規登録が完了しました"
      sign_in(:customer, @customer)
      redirect_to customers_path
    else
      render :new_profile
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the customer wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender, :birthyear, :birthdate, :height, :target_weight, :target_body_fat_percentage, :diet_style1, :diet_style2, :diet_style3, :diet_style4])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :name, :profile_image, :introduce, :gender, :birthyear, :birthdate, :height, :target_weight, :target_body_fat_percentage, :diet_style1, :diet_style2, :diet_style3, :diet_style4])
  end

  def update_resource(resource, params)
    if resource.email == 'guest@example.com' && params[:email] != 'guest@example.com'
      params[:email] = 'guest@example.com'
      flash[:alert] = "ゲストユーザーのメールアドレスは変更できません"
    end
    resource.update_without_password(params)
  end

  def after_update_path_for(_resource)
    setting_path
  end

  def after_sign_up_path_for(resource)
    diaries_path
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
