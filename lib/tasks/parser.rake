require 'parsers/auto'
namespace :parser do
  desc "Send reminder to inactive users"
  task :auto => :environment do
    AutoParser.new.execute
  end
end
