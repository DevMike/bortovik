source "https://rubygems.org"

gem 'rails', '~> 4.1.5'
gem 'rake', '~> 10.0.4'

gem 'pg', '~> 0.17.1'

# Authentication and authorization
gem 'devise', '~> 3.3.0'
gem 'devise-encryptable', '~> 0.2.0'
gem 'omniauth', '~> 1.2.2'
gem 'omniauth-facebook', '~> 2.0.0'
gem 'omniauth-vkontakte', '~> 1.3.2'

gem 'compass-rails', '~> 2.0.0'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '~> 2.5.3'
gem 'haml-rails', '~> 0.5.3'
gem 'therubyracer', '~> 0.11.4', :platform => :ruby
gem 'libv8', '~> 3.11.8.17', :platform => :ruby #therubyracer dependency, may be optional in future
gem 'coffee-rails', '~> 4.0.1'

gem 'less-rails'
gem 'twitter-bootstrap-rails', '~> 3.2.0'
gem 'simple_form', '~> 3.0.2'
# gem 'client_side_validations', '~> 3.2.6'
# gem 'client_side_validations-simple_form', '~> 2.1.0'

# Rake task schedule
gem 'whenever', '~> 0.8.4', :require => false

# Permissions
gem 'cancan', '~> 1.6.10'

# config yaml file
gem 'rails_config', '~> 0.4.2'

# imagemagick support
gem 'mini_magick', '~> 3.5.0'

# admin backend
gem 'activeadmin', '~> 1.0.0.pre', github: 'activeadmin'

gem 'rack-rewrite', '~> 1.3.3'

# AR enum attributes
gem 'enumerize', '~> 0.8.0'

#monetize
gem 'money-rails', '~> 0.12.0'

gem 'ckeditor', '~> 4.1.0'

# attachments
gem 'paperclip', '~> 4.2.0'
gem "cocaine", "= 0.3.2"
gem 'carrierwave', '~> 0.10.0'

gem 'activerecord-session_store', '~> 0.1.0'

# Database-backed asynchronous priority queue system
# @TODO: could be enabled later
#gem 'delayed_job', '~> 3.0.1'
#gem 'delayed_job_active_record', '~> 0.3.2'

# search support
# @TODO: could be used later for filters and autocomplete
#gem 'meta_search', '~> 1.1.3'

# config in database
# @TODO: could be enabled later
#gem 'rails-settings-cached'

# Deploy
# heroku require it
gem 'thin', '~> 1.5.1'

# @TODO: could be enabled later
#gem 'capistrano', '~> 2.11.2'
#gem 'capistrano-ext', '~> 1.2.1'

# Google Analytics Export API Ruby Wrapper
# @TODO: could be enabled later
#gem 'simple_analytics', '~> 0.0.1'

# Exceptions notifications
# @TODO: could be enabled later
#gem 'airbrake', '~> 3.0.rc2'

# soft delete
# @TODO: could be enabled later
# gem 'soft_destroyable', '~> 0.5.0', :git => 'git://github.com/stasl/soft_destroyable.git'

# Performance monitoring
# @TODO: could be enabled later
# gem 'newrelic_rpm', '~>3.3.1'

#parser gems
gem 'mechanize', '~> 2.5.1'
#unicode support
gem 'unicode', '~> 0.4.4.1'

gem 'mysql', :require => false

group :test, :development do
  gem 'rspec-rails', '~> 3.0.2'
  gem 'shoulda-matchers', '~> 2.6.2'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'syntax', '~> 1.2.0'
  gem 'faker', '~> 1.4.3'
  gem 'parallel_tests', '~> 1.0.5'
  gem 'pry', '~> 0.10.1'
end

group :development do
  gem 'bullet', '~> 4.13.1'
  gem 'letter_opener', '~> 1.2.0'
  #vkontakte test
  #gem 'localtunnel'

  gem 'annotate', '~> 2.6.5'
  gem 'quiet_assets', '~> 1.0.3'
end

group :test do
  gem 'selenium-webdriver', '~> 2.42.0'
  gem 'capybara', '~> 2.4.1'
  # gem 'database_cleaner', '~> 1.3.0'
  gem 'database_cleaner'#, git: 'git@github.com:bmabey/database_cleaner.git'
  gem "spork", "~> 1.0.0r3"
  gem 'email_spec', '~> 1.6.0'
  gem 'timecop', '~> 0.7.1'
end
