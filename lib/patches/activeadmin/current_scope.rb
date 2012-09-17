ActiveAdmin::ResourceController.class_eval do
  def current_scope
    @current_scope ||= params[:scope].present? ?
        active_admin_config.get_scope_by_id(params[:scope]) :
        active_admin_config.default_scope
  end
end
