class NotificationMailer < ApplicationMailer

  def complete_mail(customer)
    @customer = customer
    @url = "#{ENV['HOST']}diaries"
    mail(subject: "登録完了" ,to: @customer.email)
  end

end
