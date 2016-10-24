class Admin::BookToursController < ApplicationController
  layout "admin"
  before_action :verify_admin, only: [:index, :destroy]
  before_action :load_book_tours, only: :destroy
  before_action :load_tours, only: [:destroy, :index]

  def index
    @book_tours = @tour.book_tours.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def destroy
    if @book_tour.destroy
      flash[:success] = t "admin.manager.book_tour.message_success"
    else
      flash[:danger] = t "admin.mqanager.book_tour.message_failed"
    end
    redirect_to admin_book_tours_path
  end

  private
  def load_tours
    @tour = Tour.find_by id: params[:tour_id]
    unless @tour
      redirect_to admin_root_path
    end
  end

  def load_book_tours
    @book_tour = BookTour.find_by id: params[:id]
    unless @book_tour
      redirect_to admin_root_url
    end
  end
end
