class VehiclesController < ApplicationController
  before_filter :get_owner, only: [:index, :new, :create]

  def index
    @vehicles = @user.vehicles
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    if @user.vehicles.create(params[:vehicle])
      redirect_to user_vehicles_path(@user), notice: t('vehicle.added')
    else
      render :new
    end
  end

  private
  def get_owner
    @user = User.find(params[:user_id])
  end
end
