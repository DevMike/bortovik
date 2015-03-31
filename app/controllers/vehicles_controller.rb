class VehiclesController < ApplicationController
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
    @vehicle = Vehicle.new(vehicle_params)

    uv = @vehicle.user_vehicles.last
    uv.user = current_user
    uv.vehicle = @vehicle
    if @vehicle.save
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

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  private def vehicle_params
    params.require(:vehicle).permit(
      :car_brand_id,
      :car_model_id,
      :car_modification_id,
      :release_year,
      :engine_volume,
      :transmission,
      :vin,
      :color,
      :mileage,
      user_vehicles_attributes: [:id, :date_of_purchase, :mileage_on_purchase]
    )
  end
end
