module ActiveAdmin
  module Inputs
    class FilterMultiparameterInput < ::Formtastic::Inputs::StringInput
      include ::ActiveAdmin::Inputs::FilterBase

       def to_html
         input_wrapping do
           input_html
         end
       end

      def input_html
        raise ArgumentError, "No multiparameter fields specified" if options[:fields].blank?
        html = ''
        options[:fields].each_with_index do |field_config, i|
          field_options = field_config.dup
          field_type = field_options.delete(:field_type) || :text
          type_cast = field_options.delete(:type_cast) || ''
          label_text = field_options.delete(:label_text) || ''
          input_name = field_name(i + 1, type_cast)

          html << builder.label(input_name, label_text)
          html << builder.send("#{field_type}_field", input_name, field_options)
        end
        html.html_safe
      end

      def field_name(index, type_cast)
        "#{method}(#{index}#{type_cast})"
      end
    end
  end
end
