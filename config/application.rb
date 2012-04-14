require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "rails/all"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Bortovik
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :customer_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Kyiv'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    #config.i18n.default_locale = Settings.system.default_locale

    #fallbacks for translations
    config.i18n.fallbacks = true

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enforce that all models define their accessible attributes
    config.active_record.whitelist_attributes = true

    config.sass.preferred_syntax = :scss

    config.generators do |g|
      g.helper false
      g.test_framework :rspec, :view_specs=> false, :fixture_replacement => :factory_girl
      g.options[:factory_girl][:dir] = 'spec/factories'
      g.assets :javascripts => false, :stylesheets => false
    end

    # Enable the asset pipeline
    config.assets.enabled = true
    config.assets.version = '2.0'
    config.assets.prefix = '/assets'
  end
end
