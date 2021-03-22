class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @contacts = Contact.page(params[:page]).per(20)
  end
  
  def destroy_all
    Contact.where(id: params[:contact_ids]).destroy_all
    flash[:notice] = "選択したお問い合わせが削除されました"
    redirect_to admin_contacts_path
  end
end

