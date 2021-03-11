class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @contacts = Contact.page(params[:page]).per(20)
  end
end
