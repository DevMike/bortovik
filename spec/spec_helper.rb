require 'spork'

#configuration
Spork.prefork do
  if ENV["COVERAGE"]
    require 'simplecov'
    SimpleCov.coverage_dir('spec/coverage')
    SimpleCov.start 'rails'
  end

  ENV["RAILS_ENV"] ||= 'test'

  require "rails/application"
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'
  require 'capybara/rails'
  require 'database_cleaner'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  Dir[Rails.root.join("spec/models/shared_examples/*.rb")].each {|f| require f}

  Capybara.server_port = 9887 + ENV['TEST_ENV_NUMBER'].to_i

  # If use chrome download chromedriver from http://code.google.com/p/chromedriver/downloads/list
  # put it to appropriated place('/usr/bin' for linux)
  # and make executable - sudo chmod +x /usr/bin/chromedriver
  # don't forget to add following line to your local.yml:  browser: :chrome
  browser = Settings.browser || :firefox
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => browser)
  end

  RSpec.configure do |config|
    config.include Capybara::DSL

    config.mock_with :rspec
    config.use_transactional_fixtures = false

    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
      Rake.application.init
      Rake.application.load_rakefile
    end

    config.before(:each) do
      DatabaseCleaner.clean
      DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    # Add user helpers
    config.extend UserMacros::Request, :type => :request
    config.extend UserMacros::Controller, :type => :controller

    config.include Warden::Test::Helpers, :type => :request
    config.include Devise::TestHelpers, :type => :controller
  end

  # Clean up all dependencies to force reload
  #ActiveSupport::Dependencies.clear
end
Spork.each_run do
  FactoryGirl.reload
end

#custom methods
def file_exists?(model, type, id)
  File.exists?(Rails.root+"public/uploads/#{model}/#{type}/#{id}/company_logo.png")
end

def file_delete(model, type, id)
  path = Rails.root+"public/uploads/#{model}/#{type}/#{id}/company_logo.png"
  File.delete path if File.exists? path
end

def should_have_errors_for(container, count = 1)
  page.within(container) do
    page.all("span.error").count.should == count
  end
end

alias :should_have_error_for :should_have_errors_for

def should_render_template_with_error(template, message)
  response.should render_template(template)
  flash[:alert].should == message
end

def fill_in_form(prefix, attributes, inputs, options = {})
  if inputs[:text]
    inputs[:text].each do |field|
      fill_in "#{prefix}_#{field}", :with=> (options[:empty_set] ? '' : attributes[field])
    end
  end

  if inputs[:select]
    inputs[:select].each do |field|
      select (options[:empty_set] ? '' : attributes[field]), :from => "#{prefix}_#{field}"
    end
  end

  if inputs[:radio]
    inputs[:radio].each do |value|
      choose value
    end
  end

  if inputs[:checkbox]
    inputs[:checkbox].each do |value|
      check value
    end
  end
end

def submit_form
  find('input[@name=commit]').click
end

def unselected_currencies(currency=nil)
  User::CURRENCIES.reject{|c| c == (currency || Money.default_currency.to_s)}
end