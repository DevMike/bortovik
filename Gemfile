source "http://rubygems.org"

gem "rails", "~> 3.2.3"
gem "rake", "~> 0.9.3.beta.1"

gem "pg", "~> 0.13.2"

# View related gems
gem "compass", "0.12.1"
gem "sass-rails", "~> 3.2.5"
gem "uglifier", "~> 1.2.4"
gem "haml-rails", "~> 0.3.4"
gem "jquery-rails", "~> 2.0.2"
gem "therubyracer",  "~> 0.10.1"

# Rake task schedule
gem "whenever", "~> 0.7.3", :require => false

# Permissions
gem "cancan", "~> 1.6.7"

# Country management
gem "carmen", "~> 0.2.13"

# config yaml file
gem "rails_config", "~> 0.2.5d"

# uploader
# @TODO: need to be sure that this gem is the best to work with images
gem 'carrierwave', "~> 0.6.2", :git => "git://github.com/jnicklas/carrierwave.git"
gem 'rack-raw-upload'

# use fork because original gem last update 2010, this fork contains other forks updates and few bug fixes
gem "bitmask-attribute", :git => "git://github.com/stasl/bitmask-attribute"

# form builder
gem "simple_form", "~> 2.0.1"

# imagemagick support
gem "mini_magick", "~> 3.4"

# pagination
gem "kaminari", "~> 0.13.0"

# admin backend
gem "activeadmin", "~> 0.4.3"

gem "rack-rewrite", "~> 1.2.1"

# AR enum attributes
gem "enumerize", "~> 0.1.1"

# Database-backed asynchronous priority queue system
# @TODO: could be enabled later
#gem "delayed_job", "~> 3.0.1"
#gem "delayed_job_active_record", "~> 0.3.2"

# search support
# @TODO: could be used later for filters and autocomplete
#gem "meta_search", "~> 1.1.3"

# config in database
# @TODO: could be enabled later
#gem "rails-settings-cached"

# Deploy with Capistrano
# @TODO: could be enabled later
#gem "capistrano", "~> 2.11.2"
#gem "capistrano-ext", "~> 1.2.1"

# Google Analytics Export API Ruby Wrapper
# @TODO: could be enabled later
#gem "simple_analytics", "~> 0.0.1"

# Exceptions notifications
# @TODO: could be enabled later
#gem "airbrake", "~> 3.0.rc2"

# soft delete
# @TODO: could be enabled later
# gem "soft_destroyable", "~> 0.5.0", :git => "git://github.com/stasl/soft_destroyable.git"

# Performance monitoring
# @TODO: could be enabled later
# gem "newrelic_rpm", "~>3.3.1"

group :test, :development do
  gem "rspec-rails", "~>2.8.1"
  gem "shoulda-matchers", "~> 1.0.0"
  gem "factory_girl_rails", "~> 1.6.0"
  #gem "ruby-debug19", :require => "ruby-debug"
  gem "syntax", "~> 1.0.0"
  gem "rails3-generators", "~> 0.17.4"
  gem "autotest", "~> 4.4.6"
  gem "autotest-notification", "~> 2.3.4"
  gem "simplecov", "~> 0.5.4", :require => false
  gem "faker", "~> 1.0.1"
  gem "parallel_tests", "~> 0.6.18"
end

group :development do
  gem "bullet"
  # Local mailer
  gem "mailcatcher", "~> 0.5.1"
end

group :test do
  gem "selenium-webdriver", "~> 2.20.0"
  gem "capybara", "~> 1.1.2"
  gem "launchy", "~> 2.0.5"
  gem "ci_reporter", "~> 1.7.0"
  gem "database_cleaner", "~> 0.7.1"
  gem "fuubar", "~> 1.0.0"
  gem "spork", "~> 1.0.0r2"
  gem "email_spec", "~> 1.2.1"
end
