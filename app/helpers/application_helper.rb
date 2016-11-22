module ApplicationHelper
  def logged_in?
    current_user.present?
  end

  def verify_admin
    unless current_user.is_admin?
      redirect_to root_url
    end
  end

  def revenue_on_oneday
    BookTour.joins(:tour).where('book_tours.created_at BETWEEN ? AND ?',
      DateTime.now.beginning_of_day, DateTime.now.end_of_day)
      .sum("tours.price*book_tours.people_number")
  end
end
