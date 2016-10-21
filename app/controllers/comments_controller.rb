class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_review
  before_action :load_comment, except: :create

  def index
    @comments = Comment.latest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def create
    @comment = @review.comments.create comment_params
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = t "comment.added"
          redirect_to @review
        end
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @comment.update_attributes comment_params
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.html do
          flash[:success] = t "comment.deleted"
          redirect_to @review
        end
        format.js
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge! user_id: current_user.id
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
