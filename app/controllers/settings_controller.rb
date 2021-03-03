class SettingsController < ApplicationController
  
  def setting
    @customer = Customer.find(current_customer.id)
  end
end
