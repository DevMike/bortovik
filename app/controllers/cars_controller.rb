class CarsController < ApplicationController
  skip_before_filter :authenticate_user!

  CARS_MAPPER = {
    'car_brand' => 'car_model',
    'car_model' => 'car_modification'
  }

  def get_collection
    if CARS_MAPPER.include?(params[:resource])
      resource = params[:resource].camelize.constantize
      method = CARS_MAPPER[params[:resource]].pluralize
      @list = resource.find(params[:id]).send(method)
      @child_resource = CARS_MAPPER[params[:resource]]
    end
  end
end
