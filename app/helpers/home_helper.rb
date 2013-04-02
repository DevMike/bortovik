module HomeHelper
  def sender_input_attributes_for(attr, message)
    value = message.send(attr)
    value = current_user[attr] if value.blank? && user_signed_in?
    {value: value, readonly: value.present?}
  end

  def link_to_service(service)
    link_to raw(t(:"auth.register_via") + image_tag("#{service}.png")), user_omniauth_authorize_path(service)
  end
end