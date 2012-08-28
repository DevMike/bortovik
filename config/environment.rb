# Load the rails application
require File.expand_path('../application', __FILE__)
require 'bortovik'
if defined?(PhusionPassenger)
  require 'passenger_postgress'
end

Bortovik::Application.configure do
  config.assets.precompile += %w(
  )
end

# Initialize the rails application
Bortovik::Application.initialize!

require 'patches/activeadmin/resource_controller'
require 'patches/activeadmin/locale'
require 'patches/activeadmin/comment'
