class Admin::ReviewsController < ApplicationController
  layout "admin"
  before_action :verify_admin, only: [:index, :destroy]
  before_action :load_reviews, only: :destroy
  before_action :load_category_reviews, only: [:destroy, :index]

  def index
    @reviews = @category_review.reviews.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def destroy
    if @review.destroy
      flash[:success] = t "admin.manager.review.destroy_success"
    else
      flash[:danger] = t "admin.mqanager.review.destroy_failed"
    end
    redirect_to admin_reviews_path
  end

  private
  def load_category_reviews
    @category_review = CategoryReview.find_by id: params[:tour_id]
    unless @category_review
      redirect_to admin_root_path
    end
  end

  def load_book_tours
    @review = Review.find_by id: params[:id]
    unless @review
      redirect_to admin_root_url
    end
  end
end
