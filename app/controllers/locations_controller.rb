class LocationsController < ApplicationController
  skip_before_filter :authenticate_user!

  def get_collection
    if params[:region_id].present?
      resource = Settlement
      param_to_find = 'region_id'
    else
      resource = Region
      param_to_find = 'country_id'
    end

    @list = resource.send("find_all_by_#{param_to_find}", params[param_to_find])
    @list = Hash[*@list.map { |c| [c.id, c.name] }.flatten]
    render json: @list
  end
end