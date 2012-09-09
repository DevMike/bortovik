module HomeHelper
  def sender_input_attributes_for(attr, message)
    value = message[attr]
    value = current_user[attr] if value.blank? && user_signed_in?
    { :value => value, :readonly => value.present? }
  end
end