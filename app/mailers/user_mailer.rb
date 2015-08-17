class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email(user)
   #@user = User.last
    @url  = 'http://example.com/login'
    mail(to: user.email,
         subject: 'Welcome to My Awesome Site',
         template_path:'user_mailer'
         )

  end

end
