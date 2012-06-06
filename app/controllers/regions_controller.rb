class RegionsController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
    @list = Region.find_all_by_country_id(params[:country_id])
    @list = Hash[*@list.map { |c| [c.id, c.name] }.flatten]
    render json: @list
  end
end
