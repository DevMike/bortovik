# Overrides page_entries_info kaminari helper to add I18n

module Kaminari
  # = Helpers
  module ActionViewExtension
    def page_entries_info(collection, options = {})
      entry_name = options[:entry_name] || (I18n.t("pagination.models.#{collection.first.class.name.downcase}", :count => collection.total_count))
      if collection.num_pages < 2
        case collection.total_count
        when 0; I18n.t(:'pagination.single_page.zero',  :model => entry_name)
        when 1; I18n.t(:'pagination.single_page.one',   :model => entry_name)
        else;   I18n.t(:'pagination.single_page.other', :model => entry_name, :count => collection.total_count)
        end
      else
        offset = (collection.current_page - 1) * collection.limit_value
        I18n.t(:'pagination.multi_page', :model => entry_name, 
                                         :from => offset + 1,
                                         :to => offset + collection.count,
                                         :count => collection.total_count)
      end
    end
  end
end
