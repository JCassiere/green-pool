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
    trip = Trip.new(trip_params)
    if trip.save
      flash[:notice] = "New trip created"
      redirect_to users_show_path(trip.user_id)
    else
      flash[:alert] = "No trip created - please try again"
      redirect_to new_trip_path
    end
  end

  def destroy
    trip = Trip.find(params[:id])
    @user = trip.user
    @pickup_numbers = trip.pickups.map { |pickup| pickup.user.phone_number }
    trip.destroy
    flash[:notice] = "Trip cancelled"
    redirect_to send_sms_path(
      final_path: users_show_path(@user),
      body: "#{@user.full_name} has cancelled their trip and will no longer be picking up your recycling.  Please find another trip.",
      sms_numbers: @pickup_numbers
    )
  end

  private
  def trip_params
    params.require(:trip).permit(:total_space, :pickup_time, :user_id)
  end

end
