require 'import/autos_posts'
namespace :import do
  desc "Import posts from WordPress site"
  task :autos_posts => :environment do
    AutosPostsImporter.execute
  end
end
