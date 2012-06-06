class CountriesController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
    @list = Country.all
  end
end
