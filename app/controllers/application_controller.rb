class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    root_path
  end

  def after_sign_in_path_for(resource)
      case resource
      # when Admin
      #   admin_orders_path
      when Customer
        root_path
      end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender, :birthyear, :birthdate, :height, :target_weight, :target_body_fat_percentage, :diet_style1, :diet_style2, :diet_style3, :diet_style4])
  end
end
