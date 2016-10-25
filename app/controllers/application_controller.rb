class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def verify_admin
    unless current_user.is_admin?
      redirect_to root_url
    end
  end

  protected
  def configure_permitted_parameters
    added_attrs = [:avatar, :name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end
