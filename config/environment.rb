# Load the rails application
require File.expand_path('../application', __FILE__)
require 'bortovik'
if defined?(PhusionPassenger)
  require 'passenger_postgress'
end

class BitmaskAttribute::Definition
    def validate_for(model)
      # The model cannot be validated if it is preloaded and the attribute/column is not in the
      # database (the migration has not been run).  This usually
      # occurs in the 'test' and 'production' environments.
      return if defined?(Rails) && Rails.configuration.cache_classes

begin
      unless model.columns.detect { |col| col.name == attribute.to_s }
        raise ArgumentError, "`#{attribute}' is not an attribute of `#{model}'"
      end
rescue ActiveRecord::StatementInvalid
  # PGError: ERROR:  relation "users" does not exist
  # LINE 4:              WHERE a.attrelid = '"users"'::regclass
  #:             SELECT a.attname, format_type(a.atttypid, a.atttypmod), d.adsrc, a.attnotnull
  #              FROM pg_attribute a LEFT JOIN pg_attrdef d
  #                ON a.attrelid = d.adrelid AND a.attnum = d.adnum
  #             WHERE a.attrelid = '"users"'::regclass
  #               AND a.attnum > 0 AND NOT a.attisdropped
  #             ORDER BY a.attnum
end
    end
end

Bortovik::Application.configure do
  config.assets.precompile += %w(
  )
end

# Initialize the rails application
Bortovik::Application.initialize!

require 'patches/activeadmin/resource_controller'
require 'patches/activeadmin/locale'
require 'patches/activeadmin/comment'
