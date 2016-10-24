class BookTour < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  has_one :card
  accepts_nested_attributes_for :card

  validates :people_number, presence: true

  def paypal_url(return_path)
    values = {
      business: Settings.business,
      cmd: "_xclick",
      upload: 1,
      return: "#{Rails.application.secrets.app_host}#{return_path}",
      invoice: id,
      amount: people_number * tour.price,
      quantity: "1",
      notify_url: "#{Rails.application.secrets.app_host}/update"
    }
   "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" +
     values.to_query
  end
end
