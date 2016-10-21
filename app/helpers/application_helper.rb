module ApplicationHelper
  def logged_in?
    current_user.present?
  end

  def verify_admin
    unless current_user.is_admin?
      redirect_to root_url
    end
  end
end
