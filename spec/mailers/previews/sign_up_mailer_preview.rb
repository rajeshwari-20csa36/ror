# Preview all emails at http://localhost:3000/rails/mailers/sign_up_mailer
class SignUpMailerPreview < ActionMailer::Preview
  default from: 'your_email@example.com'

  def signup_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Your App!')
  end
end
