require 'core_ext'
require 'patches/simple_form/errors'

module Bortovik
  autoload :Strip, 'bortovik/strip'
end

ActiveRecord::Base.send(:include, Bortovik::Strip)