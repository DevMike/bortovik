class VehiclesController < ApplicationController
  load_and_authorize_resource

  def index
    @vehicles = current_user.vehicles
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def new
    @vehicle = Vehicle.new
    @vehicle.car_modification = CarModification.first
    @vehicle.user_vehicles.build
  end

  def create
    @vehicle = Vehicle.new(params[:vehicle])

    if @vehicle.save
      uv = @vehicle.user_vehicles.build params[:vehicle][:user_vehicle]
      uv.user = current_user
      uv.save
      redirect_to user_vehicles_path(current_user), notice: t('vehicle.added')
    else
      render :new
    end
  end

  def update
    if @vehicle.update_attributes(params[:vehicle])
      redirect_to user_vehicles_path(current_user), notice: t('vehicle.updated')
    else
      render partial: 'form'
    end
  end
end
