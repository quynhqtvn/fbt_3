class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews =  @user.reviews.paginate(page: params[:page], per_page: 5)
  end
end
