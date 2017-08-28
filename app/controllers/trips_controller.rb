class TripsController < ApplicationController
  before_action :authorize
  
  def new
  	@driver = current_user
  end

  def show
  end

  def index
  end

  def create
  end

  private
  def trip_params
    params.require(:trip).permit(:total_space, :pickup_time, :user_id)
  end

end