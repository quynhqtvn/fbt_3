class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @comment = current_user.comments.build comment_params
    respond_to do |format|
      format.html {redirect_to @comment.review}
      format.js
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to @comment.review}
      format.js
    end
  end

  def edit
  end

  def update
    @comment.update_attributes comment_params
    respond_to do |format|
      format.html {redirect_to @comment.review}
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content, :review_id
  end

  def load_review
    @review = Review.find_by id: params[:review_id]
    unless @review
      flash[:danger] = t "review.not_found"
      redirect_to root_path
    end
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    unless @comment
      flash[:danger] = t "comment.not_found"
      redirect_to root_path
    end
  end
end
