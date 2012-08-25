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

  Capybara.server_port = 9887 + ENV['TEST_ENV_NUMBER'].to_i

  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = false

    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
      Rake.application.init
      Rake.application.load_rakefile
    end

    config.before(:each) do
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
      fill_in "#{prefix}_#{field}", :with=> (options[:empty_set] ? '' : @attributes[field])
    end
  end

  if inputs[:select]
    inputs[:select].each do |field|
      select (options[:empty_set] ? '' : @attributes[field]), :from => "#{prefix}_#{field}"
    end
  end

  if inputs[:radio]
    inputs[:radio].each do |value|
      choose value
    end
  end
end
