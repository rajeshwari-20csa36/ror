class SignUpMailerJob < ApplicationJob
  # include Sidekiq::Job
  queue_as :default

  def perform(user)
    SignUpMailer.signup_confirmation(user).deliver_now
  end
end
