#!/usr/bin/env rake

require File.expand_path('../config/application', __FILE__)

Bortovik::Application.load_tasks

if ENV["RAILS_ENV"] == 'test'

  require 'rspec/core/rake_task'

  task(:default).clear
  task :default => [:spec]

end
