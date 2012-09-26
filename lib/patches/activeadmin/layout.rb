ActiveAdmin::ResourceController.class_eval do

  def determine_active_admin_layout
    ActiveAdmin::ResourceController::ACTIVE_ADMIN_ACTIONS.include?(params[:action].to_sym) || request.xhr? ? false : 'active_admin'
  end

end