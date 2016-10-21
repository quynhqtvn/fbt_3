class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_review, except: [:new, :index, :create]
  before_action :load_category, only: [:edit, :new]

  def index
    @reviews = Review.latest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    @comments = @review.comments.latest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build review_params
    if @review.save
      flash[:success] = t "review.create_successfull"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "review.update_successfull"
      redirect_to reviews_path
    else
      flash[:notice] = t "review.update_error"
      render :edit
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "review.delete_successfull"
    else
      flash[:notice] = t "review.delete_error"
    end
    redirect_to reviews_path
  end

  private
  def review_params
    params.require(:review).permit :title, :content, :images, :category_review_id
  end

  def load_review
    @review = Review.find_by id: params[:id]
    unless @review
      flash[:danger] = t "review.not_found"
      redirect_to root_path
    end
  end

  def load_category
    @categories = CategoryReview.sort_by_title
  end
end
