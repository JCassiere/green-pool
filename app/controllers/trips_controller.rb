class TripsController < ApplicationController
  before_action :authorize

  def new
  	@driver = current_user
    @now = Time.now.strftime("%FT%R")
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def index
    @trips = Trip.all
  end

  def create
    Trip.create(trip_params)
    redirect_to users_show_path
  end

  private
  def trip_params
    params.require(:trip).permit(:total_space, :pickup_time, :user_id)
  end

  def authorize
  end

end
