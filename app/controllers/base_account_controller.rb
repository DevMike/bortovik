class BaseAccountController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  check_authorization :unless => :devise_controller?

  def set_current_user
    User.current_user = current_user
  end

end
