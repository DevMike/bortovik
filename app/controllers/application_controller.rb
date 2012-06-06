class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery

  layout Proc.new { |controller| controller.request.xhr? ? false : 'application'}
end
