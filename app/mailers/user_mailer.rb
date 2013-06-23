class UserMailer < ActionMailer::Base
  default from: 'system@framgia.com'
  
  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: 'Welcome to My Awesome Site')
  end
  
  def active_email(user)
    @user = user
    @url = 'http://0.0.0.0:3000/users/#{user.activation_token}/activate'
    mail(to: 'admin@framgia.com', subject: 'activation account')
  end
end
