class RevenueEveryday
  include Sidekiq::Worker
  include ApplicationHelper

  REVENUE = 1

  def perform action
    case action
    when REVENUE
      venue = revenue_on_oneday
      send_email_revenue_everday venue
    end
  end

  private
  def send_email_revenue_everday venue
    UserMailer.revenue_everyday(venue).deliver_now
  end
end
