class VehiclesController < ApplicationController
  before_filter :get_owner, only: [:index, :new, :create]

  def index
    @vehicles = @user.vehicles
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(params[:vehicle])
    @vehicle.users << @user
    if @vehicle.save
      redirect_to user_vehicles_path(@user), notice: 'vehicle added'
    else
      render :new
    end
  end

  private
  def get_owner
    @user = User.find(params[:user_id])
  end
end
