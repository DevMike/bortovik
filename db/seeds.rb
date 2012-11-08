# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
require 'unicode'

module Seeder
  module Common
    def load_yaml(filename)
      file = File.open(filename)
      yaml = file.read
      YAML.load yaml
    end

    def seed_path(file)
      File.dirname(__FILE__) + "/seed/#{file}"
    end
  end

  class Locations
    class << self
      include Seeder::Common
      LOCATION_MODELS = [Country, :regions, :settlements]

      def seed
        countries_hash = load_yaml(seed_path('settlements.yml'))
        # @TODO: heroku rows restriction
        countries_hash.map! do |country_hash|
          country_hash if %w(Russia Ukraine Belarus).include?(country_hash[:name])
        end.compact!

        Country.transaction do
          process_locations(countries_hash)
        end
      end

      private
      def process_locations(locations, entity = nil, depth = 0)
        current_model = LOCATION_MODELS[depth]
        new_model = LOCATION_MODELS[depth + 1]
        locations.each do |location_hash|
          create_params = {name: location_hash[:name], russian_name: location_hash[:russian_name]}
          if entity.nil?
            new_entity = current_model.create!(create_params)
          else
            new_entity = entity.send(current_model).create!(create_params)
          end
          process_locations(location_hash[new_model], new_entity, depth + 1) if depth < LOCATION_MODELS.length - 1
        end
      end
    end
  end

  class Cars
    @models = {}

    class << self
      include Seeder::Common
      CAR_MODELS = [CarBrand, :car_models, :car_modifications]

      def seed
        cars_hash = load_yaml(seed_path('cars.yml'))
        descriptions_hash = load_yaml(seed_path('cars_posts.yml'))

        cars_hash = add_descriptions_to_cars(cars_hash, descriptions_hash)

        CarBrand.transaction do
          create_cars(nil, nil, cars_hash)
        end
      end

      private
      def create_cars(entity, name, content, depth = -1)
        unless name.nil?
          if entity.nil?
            new_entity = CAR_MODELS[depth].create!(name: name, description: content['description'], slug: content['slug'])
          else
            new_entity = entity.send(CAR_MODELS[depth]).create(name: name, description: content['description'], slug: content['slug'])
          end
        end
        content = content['children'] unless depth < 0
        content.each_pair do |key, value|
          #@TODO: after seed optimization replace with following
          # if depth < CAR_MODELS.length - 1 || (Rails.env.test? && depth==1)
          if depth < CAR_MODELS.length - 1 || depth==10
            create_cars(new_entity, key, value, depth + 1)
          else
            create_feature_category(new_entity, key, value)
          end
        end
      end

      def create_feature_category(modification, name, content)
        feature_category = find_in_hash_or_create_by_name(CarFeatureCategory, name)
        content.each_pair do |key, value|
          feature = create_feature(feature_category, key)
          map_feature(feature, modification, value) if feature
        end
      end

      def create_feature(category, name)
        feature = find_in_hash_or_create_by_name(CarFeature, name)
        feature.car_feature_category = category
        feature.tap{|f| f.save! }
      rescue Exception => error
        Rails.logger.error "Unable to create feature #{feature.name} Error: #{error}"
        nil
      end

      def map_feature(feature, modification, value)
        mapper = CarFeatureCarModification.new(value: value)
        mapper.car_modification = modification
        mapper.car_feature = feature
        mapper.save!
      rescue Exception => error
        Rails.logger.error "Unable to save feature #{feature.name} for #{modification.name}. Error: #{error}"
      end

      def find_in_hash_or_create_by_name(model, name)
        model_key = model.name
        @models[model_key] ||= {}
        @models[model_key][name] ||= model.create!(name: name)
      end

      def add_descriptions_to_cars(cars_hash, descriptions_hash)
        descriptions_hash.each do |brand|
          car_key = smart_key_search(brand['name'], cars_hash)
          if (car_key.present?)
            cars_hash[car_key]['description'] = brand['content']
            cars_hash[car_key]['slug'] = brand['slug']
            add_descriptions_to_models(cars_hash[car_key]['children'], brand['posts'])
          else
            Rails.logger.error "#{brand['name']} description is not in cars hash"
          end
        end
        cars_hash
      end

      def add_descriptions_to_models(models_hash, descriptions_hash)
        descriptions_hash.each do |model|
          model_key = smart_key_search(model['name'], models_hash)
          if (model_key.present?)
            models_hash[model_key]['description'] = model['content']
            models_hash[model_key]['slug'] = model['slug']
          else
            Rails.logger.error "#{model['name']} description is not in [#{models_hash.keys.join(', ')}]"
          end
        end
      end

      def smart_key_search(search_key, hash)
        search_key = Unicode::downcase(search_key)
        key = hash.keys.detect do |hash_key|
          prepare_pattern = Unicode::downcase(hash_key).gsub(/\s+/, '\s*')
          pattern = Regexp.new(prepare_pattern)
          search_key =~ pattern
        end
        return key unless key.nil?
        hash.keys.detect do |hash_key|
          prepare_pattern = search_key.sub(/^.+?\s+/, '').gsub(/\s+/, '\s*')
          pattern = Regexp.new(prepare_pattern)
          Unicode::downcase(hash_key) =~ pattern
        end
      end
    end
  end

  class Starter
    class << self
      def seed
        #TODO: uncomment this
        #create_app_settings!
        #Locations.seed
        Cars.seed
      end

      def create_app_settings!
        AdminUser.create!({:email => 'mihail.zarechenskiy@gmail.com', :password => '80rt0v0j', :password_confirmation => '80rt0v0j'}, :without_protection => true)
      end
    end
  end
end

Seeder::Starter.seed
