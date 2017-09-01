class PickupsController < ApplicationController
  before_action :authorize

  def new
  	@trip = Trip.find(params[:trip_id])
  	@user = current_user
  end

  def show
    @pickup = Pickup.find(params[:id])
  end

  def create
  	Pickup.create(trip_params)
  	redirect_to users_show_path
  end

  def destroy
  	pickup = Pickup.find(params[:id])
  	recycler_name = pickup.user.full_name
  	trip_id = pickup.trip_id
  	pickup.destroy
    flash[:notice] = "Pickup for #{recycler_name} denied"
    redirect_to trip_path(trip_id)
  end

  def update_status
    pickup = Pickup.find(params[:id])
    case pickup.status
    when "created"
      pickup.accepted!
    when "accepted"
      pickup.picked_up!
    when "picked_up"
      pickup.completed!
    end
    redirect_to trip_path(pickup.trip.id)
  end

  private
	def trip_params
		params.require(:pickup).permit(:trip_id, :num_bags, :user_id)
	end

end