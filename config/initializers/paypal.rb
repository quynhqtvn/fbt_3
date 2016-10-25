Rails.application.configure do
  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test  # :production when you will use a real Pro Account
    ::GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(
      login: ENV["LOGIN_PAYPAL"],
      password: ENV["PASSWORD_PAYPAL"],
      signature: ENV["SIGNATURE_PAYPAL"]
    )
  end
end
