class TripsController < ApplicationController
  before_action :authorize
  
  def new
  	@driver = current_user
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def index
  end

  def create
    @trip = Trip.create(trip_params)
    redirect_to "/users/#{current_user.id}"
  end

  private
  def trip_params
    params.require(:trip).permit(:total_space, :pickup_time, :user_id)
  end

end