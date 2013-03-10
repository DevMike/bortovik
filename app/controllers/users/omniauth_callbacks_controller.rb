class Users::OmniauthCallbacksController < ApplicationController
  User::OUTSIDE_AUTH_SERVICES.each do |service|
    define_method(:"#{service}") do
      user = User.send(:"create_or_find_by_#{service}_oauth", request.env["omniauth.auth"])

      if user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "#{service.camelize}"
        sign_in_and_redirect user, :event => :authentication
      else
        flash[:notice] = "authentication error"
        redirect_to root_path
      end
    end
  end
end