class Admin::CategoryReviewsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :load_category_review, only: [:edit, :update, :destroy]
  before_action :verify_admin

  def new
    @category_review = CategoryReview.new
  end

  def create
    @category_review = CategoryReview.new category_review_params
    if @category_review.save
      flash[:success] = t "admin.manager.category_review.create_success"
      redirect_to admin_category_reviews_path
    else
      render :new
    end
  end

  def index
    @category_reviews = CategoryReview.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @category_review.update_attributes category_review_params
      flash[:success] = t "admin.manager.category_review.update_success"
      redirect_to admin_category_reviews_path
    else
      flash[:danger] = t "admin.manager.category_review.update_failed"
      render :edit
    end
  end

  def destroy
    if @category_review.destroy
      flash[:success] = t "admin.manager.category_review.destroy_success"
    else
      flash[:danger] = t "admin.manager.category_review.destroy_failed"
    end
      redirect_to admin_category_reviews_path
  end

  private
  def load_category_review
    @category_review = CategoryReview.find_by id: params[:id]
    unless @category_review
      flash[:danger] = t "not_found"
      redirect_to admin_category_reviews_path
    end
  end

  def category_review_params
    params.require(:category_review).permit :title
  end
end
