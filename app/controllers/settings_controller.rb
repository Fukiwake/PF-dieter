class SettingsController < ApplicationController
  before_action :authenticate_customer!
  
  def setting
    @customers = current_customer.blockings
  end
end
