source "http://rubygems.org"

gem "rails", "~> 3.2.8"
gem "rake", "~> 0.9.3.beta.1"

gem "pg", "~> 0.14.1"

# Authentication and authorization
gem "devise", "~> 2.1.2"
gem "devise-encryptable", "~> 0.1.1"
gem "devise_invitable", "~> 1.1.0"

# View related gems
gem "compass-rails", "~> 1.0.3"
gem "sass-rails", "~> 3.2.5"
gem "uglifier", "~> 1.3.0"
gem "haml-rails", "~> 0.3.4"
gem "therubyracer",  "~> 0.10.2"
gem "coffee-script", "~> 2.2.0" # jquery is dependency

# Rake task schedule
gem "whenever", "~> 0.7.3", :require => false

# Permissions
gem "cancan", "~> 1.6.8"

# config yaml file
gem "rails_config", "~> 0.2.5d"

# uploader
# @TODO: need to be sure that this gem is the best to work with images
gem 'carrierwave', "~> 0.6.2"
gem 'rack-raw-upload'

# form builder
gem "simple_form", "~> 2.0.2"

gem "bitmask_attributes"

# imagemagick support
gem "mini_magick", "~> 3.4"

# pagination
gem "kaminari", "~> 0.13.0"

# admin backend
gem "activeadmin", "~> 0.5.0"

gem "rack-rewrite", "~> 1.2.1"

# AR enum attributes
gem "enumerize", "~> 0.3.0"

#monetize
gem "money-rails", "~> 0.4.0"

#markup editor
gem "ckeditor", "~> 3.7.3"

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

# Deploy
# heroku require it
gem 'thin'
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
  gem "rspec-rails", "~> 2.11.0"
  gem "shoulda-matchers", "~> 1.3.0"
  gem "factory_girl_rails", "~> 4.0.0"
  gem "syntax", "~> 1.0.0"
  gem "rails3-generators", "~> 0.17.4"
  gem "autotest", "~> 4.4.6"
  gem "autotest-notification", "~> 2.3.4"
  gem "simplecov", "~> 0.6.4", :require => false
  gem "faker", "~> 1.0.1"
  gem "parallel_tests", "~> 0.8.9"
end

group :development do
  gem "bullet"
  # Local mailer
  gem "mailcatcher", "~> 0.5.8"
  gem "mysql"
end

group :test do
  gem "selenium-webdriver", "~> 2.25.0"
  gem "capybara", "~> 1.1.2"
  gem "launchy", "~> 2.1.2"
  gem "ci_reporter", "~> 1.7.1"
  gem "database_cleaner", "~> 0.8.0"
  gem "fuubar", "~> 1.0.0"
  gem "spork", "~> 1.0.0r3"
  gem "email_spec", "~> 1.2.1"
  gem 'timecop'
end

#parser gems
gem 'mechanize', "~> 2.5.1"
