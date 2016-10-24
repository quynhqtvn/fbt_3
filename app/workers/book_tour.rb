class MonthlyWorker
  include Sidekiq::Worker

  BOOK_TOUR = 1

  def perform action
    case action
    when BOOK_TOUR
      BookTour.each do |booktour|
        send_email_when_user_book_tour booktour
      end
    end
  end

  private
  def send_email_when_user_book_tour book_tour
    UserMailer.book_tour(book_tour).deliver_now
  end
end
