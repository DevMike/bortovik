class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :set_currency
  protect_from_forgery

  layout Proc.new { |controller| controller.request.xhr? ? false : 'application'}

  protected

  def set_currency
    if params[:currency]
      MoneyRails.default_currency = params[:currency]
      current_user.update_attribute(:preferred_currency, params[:currency]) if user_signed_in?
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    MoneyRails.default_currency = current_user.preferred_currency if current_user.preferred_currency
    super
  end
end
