class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_review

  def create
    @review.likes.where(user_id: current_user.id).first_or_create
    respond_to do |format|
      format.html {redirect_to @review}
      format.js
    end
  end

  def destroy
    @review.likes.where(user_id: current_user.id).destroy_all
    respond_to do |format|
      format.html {redirect_to @review}
      format.js
    end
  end

  private
  def load_review
    @review = Review.find_by id: params[:review_id]
    unless @review
      flash[:danger] = t "review.not_found"
      redirect_to root_path
    end
  end
end
