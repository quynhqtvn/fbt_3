Rails.application.configure do
  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test  # :production when you will use a real Pro Account
    ::GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(
      login: "business_api1.vovanhai.com",
      password: "J9BRQB5RB4AA28HS",
      signature: "AFcWxV21C7fd0v3bYYYRCpSSRl31AUaeahBe-Ofa6Jtdx1JeEQ78w34e"
    )
  end
end
