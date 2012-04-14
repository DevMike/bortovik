module SimpleForm
  module Components
    module Errors
      def error_text_with_html_safe
        error_text_without_html_safe.html_safe
      end

      alias_method_chain :error_text, :html_safe
    end
  end
end
