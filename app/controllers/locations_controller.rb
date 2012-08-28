class LocationsController < ApplicationController
  skip_before_filter :authenticate_user!

  def get_collection
    if params[:region_id].present?
      resource_class = Settlement
      param_to_find = 'region_id'
    else
      resource_class = Region
      param_to_find = 'country_id'
    end

    @list = resource_class.where(param_to_find => params[param_to_find]).order("#{resource_class.name.tableize}.name")
    render :json => @list.to_json(:only => [:id, :name])
  end
end