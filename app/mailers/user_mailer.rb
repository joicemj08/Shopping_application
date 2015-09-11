#
# User mailer
#
# @author [Joice]
#
class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email(user)
    @url  = 'http://localhost:3000/users/sign_in'
    mail(to: user.email,
         subject: 'Welcome to My Awesome Site',
         template_path: 'user_mailer'
        )
  end
end
