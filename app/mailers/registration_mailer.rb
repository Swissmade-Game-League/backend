class RegistrationMailer < ApplicationMailer

  def send_payment_confirmation(user)
    @user = user
    @mail_title = "Welcome to SMGL 🎮"
    @payment = @user.payments.last
    if @payment && @payment.token
      mail(to: @user.mail, subject: @mail_title)
    end
  end

end
