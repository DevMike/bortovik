# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

module Seeder
  module Common
    def load_yaml(filename)
      file = File.open(filename)
      yaml = file.read
      YAML.load yaml
    end
  end

  class Locations
    class << self
      include Seeder::Common
      def seed
        countries_hash = load_yaml(File.dirname(__FILE__) + '/seed/settlements.yml')

        countries_hash.each do |country_hash|
          # @TODO: heroku rows restriction
          if %w(Russia Ukraine Belarus).include?(country_hash[:name])
            country = Country.new name:country_hash[:name], russian_name:country_hash[:russian_name]
            if country.valid?
              country.save!
              country_hash[:regions].each do |region_hash|
                region = country.regions.build name:region_hash[:name], russian_name:region_hash[:russian_name]
                if region.valid?
                  region.save!
                  region_hash[:settlements].each do |settlement_hash|
                    settlement = region.settlements.build name:settlement_hash[:name], russian_name:settlement_hash[:russian_name]
                    settlement.save! if settlement.valid?
                  end
                end
              end
            end
          end
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
        cars_hash = load_yaml(File.dirname(__FILE__) + '/seed/cars.yml')
        create_cars(nil, nil, cars_hash)
      end

      private
      def create_cars(entity, name, content, depth = -1)
        unless name.nil?
          if entity.nil?
            new_entity = CAR_MODELS[depth].create!(name: name)
          else
            new_entity = entity.send(CAR_MODELS[depth]).create(name: name)
          end
        end
        content.each_pair do |key, value|
          if depth < CAR_MODELS.length - 1
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
    end
  end

  class Starter
    class << self
      def seed
        create_app_settings!
        Locations.seed
        Cars.seed
      end

      def create_app_settings!
        AdminUser.create!({:email => 'mihail.zarechenskiy@gmail.com', :password => '80rt0v0j', :password_confirmation => '80rt0v0j'}, :without_protection => true)
      end
    end
  end
end

Seeder::Starter.seed
