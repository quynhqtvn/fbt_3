class Admin::ConfirmReviewsController < ApplicationController
  before_action :load_review, only: :update
  before_action :authenticate_user!
  before_action :verify_admin

  def update
    if @review.update_attributes is_confirm: params[:is_confirm]
      flash[:success] = t "category.message_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "category.message_failed"
      redirect_to admin_categories_path
    end
  end

  private
  def load_review
    @review = Review.find_by id: params[:id]
    unless @review
      flash[:danger] = t "not_found"
      redirect_to admin_categories_path
    end
  end
end
