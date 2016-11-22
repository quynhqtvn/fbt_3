class Admin::ConfirmReviewsController < ApplicationController
  before_action :load_review, only: :update
  before_action :load_category_review, only: :update
  before_action :authenticate_user!
  before_action :verify_admin

  def update
    if @review.update_attributes is_confirm: params[:is_confirm]
      flash[:success] = "Update success"
      redirect_to admin_category_review_reviews_path @category_review
    else
      flash[:danger] = "Update failed"
      redirect_to admin_category_review_reviews_path @category_review
    end
  end

  private
  def load_review
    @review = Review.find_by id: params[:id]
    unless @review
      flash[:danger] = t "not_found"
      redirect_to admin_category_review_reviews_path
    end
  end

  def load_category_review
    @category_review = CategoryReview.find_by id: params[:category_review_id]
    unless @category_review
      flash[:danger] = t "not_found"
      redirect_to admin_category_review_reviews_path
    end
  end
end
