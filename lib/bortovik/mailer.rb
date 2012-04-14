# Redefine devise default template path finder
module Devise
  module Mailers
    module Helpers
      def template_paths
        template_path = [self.class.superclass.mailer_name]
        template_path.unshift "#{@devise_mapping.scoped_path}/mailer" if self.class.scoped_views?
        template_path
      end
    end
  end
end
