# Load the rails application
require File.expand_path('../application', __FILE__)
require 'bortovik'

Rake.application.instance_eval do
  def self.display_error_message(ex)
    raise
  end
end

Bortovik::Application.configure do
  config.assets.precompile += %w(
  )
end

# Initialize the rails application
Bortovik::Application.initialize!

require 'patches/activeadmin'
# require 'patches/simple_form'