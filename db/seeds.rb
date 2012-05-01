# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#first convert db to yaml. will be commented later
=begin
database = Mysql.new('localhost', 'root', 'root', 'tmp')

query = "
  SELECT *
  FROM country_;
"
countries = []
my_countries = database.query query
my_countries.each_hash do |my_country|
  country = {:name => my_country['country_name_en'], :russian_name => my_country['country_name_ru'], :regions => []}
  countries << country

  query = "
    SELECT *
    FROM region_
    WHERE id_country=#{my_country['id_country']}
  "
  my_regions = database.query query
  my_regions.each_hash do |my_region|
    region = {:name => my_region['region_name_en'], :russian_name => my_region['region_name_ru'], :settlements => []}
    country[:regions] << region

    query = "
      SELECT *
      FROM city_
      WHERE id_region=#{my_region['id_region']}
    "
    my_settlements = database.query query
    my_settlements.each_hash do |my_settlement|
      region[:settlements] << {:name => my_settlement['city_name_en'], :russian_name => my_settlement['city_name_ru']}
    end
  end
end

puts countries.to_yaml
=end

#get settlements
settlements_file = File.open(File.dirname(__FILE__) + '/seed/settlements.yml')
settlements_yaml = settlements_file.read
countries_hash = YAML.load settlements_yaml

countries_hash.each do |country_hash|
  country = Country.create name:country_hash[:name], russian_name:country_hash[:russian_name]
  country_hash[:regions].each do |region_hash|
    region = country.regions.create name:region_hash[:name], russian_name:region_hash[:russian_name]
    region_hash[:settlements].each do |settlement_hash|
      region.settlements.create name:settlement_hash[:name], russian_name:settlement_hash[:russian_name]
    end
  end
end