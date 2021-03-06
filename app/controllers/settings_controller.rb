class SettingsController < ApplicationController
  
  def setting
    @customers = current_customer.blockings
  end
end
