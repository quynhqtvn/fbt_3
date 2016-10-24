class BookToursController < ApplicationController
  before_action :authenticate_user!

  def show
    @book_tour = BookTour.find_by id: params[:id]
    if @book_tour.nil?
      flash[:danger] = t "book_tour.not_found"
      redirect_to root_path
    end
  end

  def new
    @book_tour = BookTour.new
    @tour = Tour.find_by id: params[:tour_id]
    if @tour.nil?
      flash[:danger] = t "tour.not_found"
      redirect_to root_path
    end
  end

  def create
    @book_tour = current_user.book_tours.build book_tour_params
    if @book_tour.save
      UserMailer.book_tour(@book_tour).deliver_now
      redirect_to @book_tour
    else
      flash[:danger] = t "book_tour.failed"
      render :new
    end
  end

  private

  def book_tour_params
    params.require(:book_tour).permit :tour_id,
      :people_number, :requirement
  end
end
