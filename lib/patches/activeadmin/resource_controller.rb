ActiveAdmin::BaseController.class_eval do
  def build_resource
    get_resource_ivar || set_resource_ivar(end_of_association_chain.send(method_for_build, resource_params, :as => :site_admin))
  end

  def update(options={}, &block)
    object = resource

    if update_resource(object, [resource_params, {:as => :site_admin}])
      options[:location] ||= smart_resource_url
    end

    respond_with_dual_blocks(object, options, &block)
  end
end


ActiveAdmin::Views::IndexAsTable::IndexTableFor.class_eval do

  def default_actions(options = {}, &block)
    options[:name] ||= ''

    column options[:name] do |resource|
      links = block_given? ? yield : ''
      links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link" if controller.respond_to?(:show)
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link" if controller.respond_to?(:edit)
      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link" if controller.respond_to?(:destroy)
      links.html_safe
    end
  end

end
