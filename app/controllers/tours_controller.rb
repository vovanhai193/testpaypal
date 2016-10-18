class ToursController < ApplicationController
  def index
    @tours = Tour.all
  end

  def show
    @tour = Tour.find_by id: params[:id]
    if @tour.nil?
      flash[:danger] = "tour.not_found"
      redirect_to root_path
    end
  end
end
