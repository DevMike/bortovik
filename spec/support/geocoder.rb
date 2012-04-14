require 'geocoder/results/base'
module Geocoder
  module Result
    class Test < Base
      attr_reader :coordinates, :address, :city, :state, :state_code
      attr_reader :country, :country_code, :postal_code, :query

      def initialize(query)
        @coordinates = [rand(180) - 90, rand(360) - 180]
        @city = Faker::Address.city
        @state = Faker::Address.state
        @state_code = Faker::Address.state_abbr
        @country = 'Germany'
        @country_code = 'DE'
        @postal_code = Faker::Address.uk_postcode
        @address = [@street, "#{@postal_code} #{@city}", "#{@state} #{@country}"].join(', ')
      end
    end
  end
end

module Geocoder
  def search(query)
    [Geocoder::Result::Test.new(query)]
  end
end