class BookToursController < ApplicationController
  before_action :load_tour, only: [:new, :create]
  before_action :authenticate_user!
  def new
    @book_tour = @tour.book_tours.build
  end

  def show
    @book_tour = BookTour.find_by id: params[:id]
    if @book_tour.nil?
      redirect_to root_path
    end
  end

  def create
    @book_tour = @tour.book_tours.build book_tour_params
    if @book_tour.save
      flash[:success] = "booktour.success"
      redirect_to @book_tour.paypal_url(book_tour_path(@book_tour))
    else
      flash[:danger] = "booktour.danger"
      render :new
    end
  end

  protect_from_forgery except: [:update]
  def update
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      @book_tour = BookTour.find params[:invoice]
      @book_tour.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end

  def destroy
  end

  private

  def book_tour_params
    params.require(:book_tour).permit :user_id, :people_number, :requirement
  end

  def load_tour
    @tour = Tour.find_by id: params[:tour_id]
    if @tour.nil?
      redirect_to root_path
    end
  end
end
