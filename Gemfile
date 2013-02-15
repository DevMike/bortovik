source "http://rubygems.org"

gem "rails", "~> 3.2.12"
gem "rake", "~> 10.0.3"

gem "pg", "~> 0.14.1"

# Authentication and authorization
gem "devise", "~> 2.2.3"
gem "devise-encryptable", "~> 0.1.1"
gem "devise_invitable", "~> 1.1.5"

# View related gems
gem "compass-rails", "~> 1.0.3"
gem "sass-rails", "~> 3.2.6"
gem "uglifier", "~> 1.3.0"
gem "haml-rails", "~> 0.4"
gem "therubyracer", "~> 0.11.3", :platform => :ruby
gem "libv8", "~> 3.11.8.13", :platform => :ruby #therubyracer dependency, may be optional in future
gem "coffee-script", "~> 2.2.0" # jquery is dependency
#twitter bootstrap support
gem "less-rails", "~> 2.2.6"
gem "twitter-bootstrap-rails", "~> 2.2.3"

# Rake task schedule
gem "whenever", "~> 0.8.2", :require => false

# Permissions
gem "cancan", "~> 1.6.9"

# config yaml file
gem "rails_config", "~> 0.2.5d"

# uploader
# @TODO: need to be sure that this gem is the best to work with images
gem 'carrierwave', "~> 0.8.0"
gem 'rack-raw-upload'

# form builder
gem "simple_form", "~> 2.0.4"

gem "bitmask_attributes"

# imagemagick support
gem "mini_magick", "~> 3.5.0"

# admin backend
gem "activeadmin", "~> 0.5.1"

gem "rack-rewrite", "~> 1.3.3"

# AR enum attributes
gem "enumerize", "~> 0.5.1"

#monetize
gem "money-rails", "~> 0.7.1"

#markup editor
gem "ckeditor", :git => "https://github.com/ginter/ckeditor.git"

# attachments
gem "paperclip"

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
gem "thin", "~> 1.5.0"

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

#parser gems
gem 'mechanize', "~> 2.5.1"
#unicode support
gem 'unicode'

group :test, :development do
  gem "rspec-rails", "~> 2.12.0"
  gem "shoulda-matchers", "~> 1.4.2"
  gem "factory_girl_rails", "~> 4.2.1"
  gem "syntax", "~> 1.0.0"
  gem "rails3-generators", "~> 1.0.0"
  gem "faker", "~> 1.1.2"
  gem "parallel_tests", "~> 0.9.3"
end

group :development do
  gem "bullet"
  # Local mailer
  gem "mailcatcher", "~> 0.5.10"
  # for debugging
  gem "pry", "~> 0.9.10"
end

group :test do
  gem "selenium-webdriver", "~> 2.29.0"
  gem "capybara", :git => "https://github.com/DevMike/capybara.git"
  gem "database_cleaner", "~> 0.9.1"
  gem "spork", "~> 1.0.0r3"
  gem "email_spec", "~> 1.4.0"
  gem "timecop", "~> 0.5.9.2"
  gem "mysql", :require => false
end
