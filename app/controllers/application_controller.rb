class ApplicationController < ActionController::Base
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

  #redefine default devise methods
  def after_sign_in_path_for(resource_or_scope)
    admin_dashboard_path and return if resource_or_scope == :admin_user
    MoneyRails.default_currency = current_user.preferred_currency if current_user.preferred_currency
    super
  end

  def stored_location_for(resource_or_scope)
    resource_or_scope.is_a?(AdminUser) ? super : nil
  end
end
