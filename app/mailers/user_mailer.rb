class UserMailer < ActionMailer::Base
  default from: "gtiengenhariajr@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_send.subject
  #
  def password_send(user)
    @user = user

    mail to: @user.email, subject: 'Sua senha de acesso =D'
  end
end
