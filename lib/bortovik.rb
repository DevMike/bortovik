require 'patches/simple_form/errors'
require 'bortovik/validators'

module Bortovik
  autoload :Strip, 'bortovik/strip'
end

ActiveRecord::Base.send(:include, Bortovik::Strip)