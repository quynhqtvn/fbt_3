class BookToursController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery except: :update

  def show
    @book_tour = BookTour.find_by id: params[:id]
    if @book_tour.nil?
      flash[:danger] = t "book_tour.not_found"
      redirect_to root_path
    end
  end

  def new
    @book_tour = BookTour.new
    @book_tour.build_card
    @tour = Tour.find_by id: params[:tour_id]
    if @tour.nil?
      flash[:danger] = t "tour.not_found"
      redirect_to root_path
    end
  end

  def create
    if params[:payment_method] == Settings.paypal
      @book_tour = current_user.book_tours.build book_tour_paypal_params
    else
      @book_tour = current_user.book_tours.build book_tour_card_params
      @book_tour.card.ip_address = request.remote_ip
    end
    if @book_tour.save
      if params[:payment_method] == Settings.paypal
        redirect_to @book_tour.paypal_url book_tour_path(@book_tour)
      elsif params[:payment_method] == Settings.card
        if @book_tour.card.purchase
          redirect_to book_tour_path(@book_tour),
            notice: @book_tour.card.card_transaction.message
        else
          redirect_to book_tour_path(@book_tour),
            alert: @book_tour.card.card_transaction.message
        end
      end
    else
      render :new
    end
  end

  def update
    params.permit!
    status = params[:payment_status]
    if status == t(:completed)
      @book_tour = BookTour.find params[:invoice]
      @book_tour.update_attributes notification_params: params, status: status,
        transaction_id: params[:txn_id], purchased_at: Time.now
    end
  end

  private

  def book_tour_card_params
    params.require(:book_tour).permit :tour_id, :people_number, :requirement,
      card_attributes: [:first_name, :last_name, :card_type, :card_number,
        :card_verification, :card_expires_on]
  end

  def book_tour_paypal_params
    params.require(:book_tour).permit :tour_id, :people_number, :requirement
  end
end
