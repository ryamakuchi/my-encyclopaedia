module AuthSupport
  def user_sign_up (mail_address:, password:, confirmation: true)
    create(
      :user,
      email: mail_address,
      password: password,
      password_confirmation: password
    )

    user_confirmation if confirmation == true
  end

  private

  def user_confirmation
    mail = ActionMailer::Base.deliveries.last
    confirmation_url = mail.body.match(/href=".*"/).to_s.slice(6..-2)
    visit confirmation_url
  end
end
