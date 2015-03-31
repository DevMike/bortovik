module Bortovik
  module Strip
    extend ActiveSupport::Concern

    included do
      # The list of all attributes which will be striped
      class_attribute :strip_attributes_options
      before_validation do |record|

        # If no limitations provided, strip all attributes by default
        (self.strip_attributes_options || attribute_names).each do |attr|
          value = self[attr.to_sym] if attr
          if value && value.respond_to?(:strip)
            record[attr] = (value.blank?) ? nil : value.strip
          end
        end
      end
    end

    module ClassMethods

      # Strip model attributes that respond to strip
      #
      # By default all fields are stripped
      # Behaviour can be changed with options :except or :only
      #
      # Examples:
      #
      #   Strip only title
      #   strip_attribute :only => :title
      #
      #   Strip all except title
      #   strip_attribute :except => :title
      def strip_attribute(options = {})
        self.strip_attributes_options = if options[:only]
                                      Array(options[:only])
                                    elsif options[:except]
                                      attribute_names - Array(options[:except]).map(&:to_s)
                                    end
      end
    end
  end
end
