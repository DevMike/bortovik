class SettlementsController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
    @list = Settlement.find_all_by_region_id(params[:region_id])
    @list = Hash[*@list.map { |c| [c.id, c.name] }.flatten]
    render json: @list
  end
end
