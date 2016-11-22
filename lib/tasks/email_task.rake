namespace :email_task do
  desc "TODO"
  task send_revenue_mail: :environment do
    RevenueEveryday.perform_async RevenueEveryday::REVENUE
  end
end
