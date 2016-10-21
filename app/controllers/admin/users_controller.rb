class Admin::UsersController < ApplicationController
  layout "admin"
  include ApplicationHelper
  before_action :verify_admin, only: [:index, :show, :destroy]
  before_action :load_user, only: [:show, :destroy]
  before_action :authenticate_user!

  def index
    @users = User.alphabet.paginate page: params[:page],
      per_page: Settings.per_pages
  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.user.delete_success"
    else
      flash[:danger] = t "admin.user.delete_failed"
    end
    redirect_to admin_users_path
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      redirect_to admin_root_url
    end
  end

  def verify_admin
    unless current_user.is_admin?
      redirect_to root_url
    end
  end
end
