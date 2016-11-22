class Admin::ToursController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :load_tour, only: [:edit, :update, :destroy]
  before_action :verify_admin

  def new
    @tour = Tour.new
    @categories = CategoryTour.all
  end

  def create
    @categories = CategoryTour.all
    @tour = Tour.new tour_params
    if @tour.save
      flash[:success] = t "admin.manager.tour.create_success"
      redirect_to admin_tours_path
    else
      render :new
    end
  end

  def index
    @tours = Tour.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @tour.update_attributes tour_params
      flash[:success] = t "admin.manager.tour.update_success"
      redirect_to admin_tours_path
    else
      flash[:danger] = t "admin.manager.tour.update_failed"
      render :edit
    end
  end

  def destroy
    if @tour.destroy
      flash[:success] = t "admin.manager.tour.destroy_success"
    else
      flash[:danger] = t "admin.manager.tour.destroy_failed"
    end
      redirect_to admin_tours_path
  end

  private
  def tour_params
    params.require(:tour).permit :category_tour_id, :name,
      :schedule, :place_departure, :time, :people_number, :transport,
      :price, :content, :time_start
  end

  def load_tour
    @tour = Tour.find_by id: params[:id]
    unless @tour
      flash[:danger] = t "not_found"
      redirect_to admin_tours_path
    end
  end
end
