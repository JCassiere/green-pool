class UsersController < ApplicationController
  before_action :authorize, :except => [:create, :new]

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to "/users/#{@user.id}"
    end
    # @user = current_user
    @trips = @user.trips
  end

  def new
  end

  def create
  	@user = User.new(user_params)
    @user.credit_count = 1
  	if @user.save
  		session[:user_id] = @user.id
  		redirect_to '/', notice: "Welcome, #{@user.first_name}!"
  	else
      flash[:error] = 'An error occured!'
  		render 'new'
  	end
  end

  def transfer
      @user = current_user
      @pickup = Pickup.find(params[:id])
      @driver = @pickup.trip.user
      @num_bags = @pickup.num_bags
      @user.credit_count -= @num_bags
      @driver.credit_count += @num_bags
      @user.save
      @driver.save
      @pickup.destroy
      redirect_to users_show_path(@user)
  end

  private
  	def user_params
  		params.require(:user).permit(
        :first_name,
        :last_name,
        :avatar,
        :phone_number,
        :email,
        :password,
        :password_confirmation,
        :street,
        :city,
        :state,
        :zip_code,
        :country
        )
  	end
end
