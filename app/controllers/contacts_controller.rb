class ContactsController < ApplicationController

  def new
    @contact = current_customer.contacts.new
  end

  def create
    contact = current_customer.contacts.new(contact_params)
    if contact.save
      flash[:notice] = "お問い合わせを送信しました"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :genre, :body)
  end
end