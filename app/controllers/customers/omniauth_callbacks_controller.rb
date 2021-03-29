# frozen_string_literal: true

class Customers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /customers/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  def twitter
    callback_for(:twitter)
  end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    @customer = Customer.from_omniauth(request.env["omniauth.auth"])
    if @customer.persisted?
      sign_in_and_redirect @customer, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      session["devise.regist_data"] = { customer: @customer.attributes }
      session["devise.regist_data"][:customer]["password"] = Devise.friendly_token[0, 20]
      redirect_to customers_new_profile_path
    end
  end

  def failure
    redirect_to root_path
  end
end
