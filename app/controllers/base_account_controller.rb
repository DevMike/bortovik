class BaseAccountController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_current_user

  check_authorization :unless => :devise_controller?

  def set_current_user
    User.current_user = current_user
  end

end
