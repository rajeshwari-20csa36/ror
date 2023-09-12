class SignUpMailer < ApplicationMailer
  def signup_confirmation(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Your App!')

  end
end
